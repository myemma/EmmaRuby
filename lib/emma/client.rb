require 'json'
require 'httparty'
require 'emma/configurable'
require 'emma/api/members'
require 'emma/api/fields'
require 'emma/api/groups'
require 'emma/api/mailings'
require 'emma/api/response'
require 'emma/api/searches'
require 'emma/api/triggers'
require 'emma/api/webhooks'


module Emma
  class Client
    include HTTParty
    
    # Include individual modules
    include Emma::API::Members
    include Emma::API::Fields
    include Emma::API::Groups
    include Emma::API::Mailings
    include Emma::API::Response
    include Emma::API::Searches
    include Emma::API::Triggers
    include Emma::API::Webhooks
    
    base_uri "https://api.e2ma.net"
    
    attr_accessor :account_id, :private_key, :public_key
    
    # On insantiation set instance variables into memory
    def initialize(options = {})
      Emma::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Emma.instance_variable_get(:"@#{key}"))
      end
      @default_params = {:basic_auth => {:username => @public_key, :password => @private_key}}
    end
    
    # HTTP GET Request
    def get(path, query = {})
      request(:get, path, query)
    end
    
    # HTTP POST Request
    def post(path, params = {})
      # options = {:body => params.to_json}
      request(:post, path, params)
    end
    
    # HTTP PUT Request
    def put(path, params = {})
      # options = {:body => params.to_json}
      request(:put, path, params)
    end
    
    # HTTP DELETE Request
    def delete(path, query = {})
      request(:delete, path, query)
    end
    
    private
      # Performs Call to API
      def request(method, path, params = {})
        self.class.debug_output($stderr) if @debug
        setup_http_body(method, params)
        
        uri = base_api_uri + path
        response = self.class.send(method.to_sym, uri, @default_params)
        parse(response)
      end
      
      def setup_http_body(method, params)
        unless params.empty?
          @default_params.merge!({:query => params}) if [:get, :delete].include? method
          @default_params.merge!({:body => params.to_json}) if [:put, :post].include? method
        end
        @default_params
      end
      
      # Appends account id to base_uri
      def base_api_uri
        "#{self.class.base_uri}/#{@account_id}"
      end
      
      # Return parsed response from API Call
      def parse(response)
        return JSON.parse('[' + response.body + ']').first
      end
    
  end
end
