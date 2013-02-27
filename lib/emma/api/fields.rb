# @see http://api.myemma.com/api/external/fields.html

module Emma
  module API
    module Fields
      # Gets a list of this account’s defined fields.
      def my_fields(params = {})
        get("/fields", params)
      end
      
      # Gets the detailed information about a particular field.
      def get_field_by_id(id, params = {})
        get("/fields/#{id}", params)
      end
      
      # Create a new field
      def add_field(params = {})
        post("/fields", params)
      end
      
      # Delete a field
      def remove_field(id)
        delete("/fields/#{id}")
      end
      
      # Clear the member data for the specified field.
      def remove_member_data_for_field(id)
        post("/fields/#{id}/clear")
      end
      
      # Updates an existing field.
      def update_field(id, params = {})
        put("/fields/#{id}", params)
      end
    end
  end
end