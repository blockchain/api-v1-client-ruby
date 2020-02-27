require 'json'
require_relative 'util'

module Blockchain

	class Wallet

		def initialize(identifier, password, url, second_password = nil, api_code = nil)
			@identifier = identifier
			@password = password
			@second_password = second_password
			@api_code = api_code
			@url = url
		end
		
		def send(to, amount, from_address: nil, fee: nil, note: nil)
			recipient = { to => amount }
			return send_many(recipient, from_address: from_address, fee: fee, note: note)
		end
		
		def send_many(recipients, from_address: nil, fee: nil, note: nil)
			params = build_basic_request()
			method = ''
			
			if recipients.size == 1
				params['to'] = recipients.keys[0]
				params['amount'] = recipients.values[0]
				method = 'payment'
			else
				params['recipients'] = JSON.dump(recipients)
				method = 'sendmany'
			end
			
			if !from_address.nil?
				params['from'] = from_address
			end
			if !fee.nil?
				params['fee'] = fee
			end
			if !note.nil?
				params['note'] = note
			end
			
			response = Blockchain::call_api("merchant/#{@identifier}/#{method}", method: 'post', data: params, base_url: @url)
			json_response = parse_json(response)
			return PaymentResponse.new(
										json_response['message'],
										json_response['tx_hash'],
										json_response['notice'])
		end
		
		def get_balance()
			response = resp = Blockchain::call_api("merchant/#{@identifier}/balance", method: 'get', data: build_basic_request(), base_url: @url)
			json_response = parse_json(response)
			return json_response['balance']
		end
		
		def list_addresses(confirmations = 0)
			params = build_basic_request()
			params['confirmations'] = confirmations
			response = Blockchain::call_api("merchant/#{@identifier}/list", method: 'get', data: params, base_url: @url)
			json_response = parse_json(response)
			
			addresses = []
			json_response['addresses'].each do |a|
				addr = WalletAddress.new(a['balance'],
											a['address'],
											a['label'],
											a['total_received'])
				addresses.push(addr)
			end
			return addresses
		end
		
		def get_address(address, confirmations = 0)
			params = build_basic_request()
			params['address'] = address
			params['confirmations'] = confirmations
			response = Blockchain::call_api("merchant/#{@identifier}/address_balance", method: 'get', data: params, base_url: @url)
			json_response = parse_json(response)
			return WalletAddress.new(json_response['balance'],
									json_response['address'],
									nil,
									json_response['total_received'])
		end
		
		def new_address(label = nil)
			params = build_basic_request()
			if !label.nil? then params['label'] = label end
			response = Blockchain::call_api("merchant/#{@identifier}/new_address", method: 'post', data: params, base_url: @url)
			json_response = parse_json(response)
			return WalletAddress.new(0,
									json_response['address'],
									json_response['label'],
									0)
		end
		
		def archive_address(address)
			params = build_basic_request()
			params['address'] = address
			response = Blockchain::call_api("merchant/#{@identifier}/archive_address", method: 'post', data: params, base_url: @url)
			json_response = parse_json(response)
			return json_response['archived']
		end
		
		def unarchive_address(address)
			params = build_basic_request()
			params['address'] = address
			response = Blockchain::call_api("merchant/#{@identifier}/unarchive_address", method: 'post', data: params, base_url: @url)
			json_response = parse_json(response)
			return json_response['active']
		end
		
		def build_basic_request()
			params = { 'password' => @password }
			if !@second_password.nil?
				params['second_password'] = @second_password
			end
			if !@api_code.nil?
				params['api_code'] = @api_code
			end
			return params
		end
		
		# convenience method that parses a response into json AND makes sure there are no errors
		def parse_json(response)
			json_response = JSON.parse(response)
			error = json_response['error']
			if !error.nil? then raise APIException.new(error) end
			return json_response
		end
	end

	class WalletAddress
		attr_reader :balance
		attr_reader :address
		attr_reader :label
		attr_reader :total_received
		
		def initialize(balance, address, label, total_received)
			@balance = balance
			@address = address
			@label = label
			@total_received = total_received
		end
	end

	class PaymentResponse
		attr_reader :message
		attr_reader :tx_hash
		attr_reader :notice
		
		def initialize(message, tx_hash, notice)
			@message = message
			@tx_hash = tx_hash
			@notice = notice
		end
	end
	
end