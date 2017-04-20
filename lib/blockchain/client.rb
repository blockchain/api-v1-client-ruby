require 'net/http'

module Blockchain

    DEFAULT_BASE_URL = 'https://blockchain.info/'
	TIMEOUT_SECONDS = 10

    class Client

        attr_reader :base_url
        attr_reader :api_code

        def initialize(base_url = nil, api_code = nil)
            @base_url = base_url.nil? ? DEFAULT_BASE_URL : base_url
            @api_code = api_code
        end

        class APIException < StandardError
	    end

        def call_api(resource, method: 'get', data: nil)
            url = URI.parse(@base_url + resource)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = @base_url.start_with? 'https://'
            http.read_timeout = TIMEOUT_SECONDS

            request = nil
            if method == 'get'
                url.query = data.nil? ? nil : URI.encode_www_form(data)
                request = Net::HTTP::Get.new(url.request_uri)
            elsif method == 'post'
                request = Net::HTTP::Post.new(url.request_uri)
                request.content_type = 'application/x-www-form-urlencoded'
                if data != nil
                then
                    if !@api_code.nil? then data['api_code'] = @api_code
                    end
                    request.set_form_data(data)
                else
                    if
                        !@api_code.nil? then data = { 'api_code' => @api_code }
                        request.set_form_data(data)
                    else {}

                    end
                end
            end
            response = http.request(request)
            if response.code != '200'
                raise APIException, response.body
            end
            return response.body
	    end
    end

end