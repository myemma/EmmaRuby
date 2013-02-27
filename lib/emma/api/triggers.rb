# @see http://api.myemma.com/api/external/triggers.html

module Emma
  module API
    module Triggers
      # Get a basic listing of all triggers in an account.
      def my_triggers(params = {})
        get("/triggers")
      end
      
      # Create a new trigger.
      def add_trigger(params = {})
        post("/triggers", params)
      end
      
      # Look up a trigger by trigger id.
      def get_trigger_by_id(id)
        get("/triggers/#{id}")
      end
      
      # Update or edit a trigger.
      def update_trigger(id, params = {})
        put("/triggers/#{id}", params)
      end
      
      # Delete a trigger.
      def remove_trigger(id)
        delete("/triggers/#{id}")
      end
      
      # Get mailings sent by a trigger.
      def get_trigger_mailings(id, params = {})
        get("/triggers/#{id}/mailings", params)
      end
    end
  end
end