require "emma/version"
require "emma/client"
require "emma/configurable"

module Emma
  class << self
    def available_categories
      [:fields, :groups, :mailings, :members, :response, :searches, :triggers, :webhooks]
    end
  end
  
  class Setup
    include Emma::Configurable
    
    attr_accessor :account_id, :public_key, :private_key, :debug
    
    def initialize(account_id = nil, public_key = nil, private_key = nil, debug = false)
      @account_id = account_id || ENV['EMMA_ACCOUNT_ID']
      @public_key = public_key || ENV['EMMA_PUBLIC_KEY']
      @private_key = private_key || ENV['EMMA_PRIVATE_KEY']
      @debug = debug
    end
    
    # establish connection
    def client
      @client = Emma::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end
    
    def respond_to_missing?(method, include_private = false)
      client.respond_to?(client, include_private)
    end
    
    private
      def method_missing(method_name, *args)
        return super unless client.respond_to?(method_name)
        client.send(method_name, *args)
      end
  end
end
