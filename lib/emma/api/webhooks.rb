# @see http://api.myemma.com/api/external/webhooks.html

module Emma
  module API
    module Webhooks
      # Get a basic listing of all webhooks associated with an account.
      def my_webhooks(params = {})
        get("/webhooks")
      end
      
      # Get information for a specific webhook belonging to a specific account.
      def get_webhook(id)
        get("/webhooks/#{id}")
      end
      
      # Get a listing of all event types that are available for webhooks.
      def webhook_events(id)
        get("/webhooks/#{id}/events")
      end
      
      # Create an new webhook.
      def add_webhook(params = {})
        post("/webhooks", params)
      end
      
      # Update an existing webhook. Takes the same params as create_webhook.
      def update_webhook(id, params = {})
        put("/webhooks/#{id}", params)
      end
      
      # Deletes an existing webhook.
      def remove_webhook(id)
        delete("/webhooks/#{id}")
      end
      
      # Delete all webhooks registered for an account.
      def remove_all_webhooks
        delete("/webhooks")
      end
    end
  end
end