module Emma
  module Configurable
    class << self
      # all keys (instance vars) available
      def keys
        @keys ||= [
            :account_id,
            :public_key,
            :private_key,
            :oauth_token,
            :debug
          ]
      end
    end
    
    private
      # return mapped Hash of available keys
      def options
        Hash[Emma::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
      end
  end
end