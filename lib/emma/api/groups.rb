# @see http://api.myemma.com/api/external/groups.html

module Emma
  module API
    module Groups
      # Get a basic listing of all active member groups for a single account.
      def my_groups(params = {})
        get("/groups", params)
      end
      
      # Create one or more new member groups.
      def add_new_groups(params = {})
        post("/groups", params)
      end
      
      # Get the detailed information for a single member group.
      def get_group_by_id(id)
        get("/groups/#{id}")
      end
      
      # Update information for a single member group.
      def update_group(id, params = {})
        put("/groups/#{id}", params)
      end
      
      # Delete a single member group.
      def remove_group(id)
        delete("/groups/#{id}")
      end
      
      # Get the members in a single active member group.
      def group_members(id, params = {})
        get("/groups/#{id}/members", params)
      end
      
      # Add a list of members to a single active member group.
      def add_members_to_group(id, params = {})
        put("/groups/#{id}/members", params)
      end
      
      # Remove members from a single active member group.
      def remove_members_from_group(id, params = {})
        put("/groups/#{id}/members/remove", params)
      end
      
      # Remove all members from a single active member group.
      def remove_all_members_from_group(id, params = {})
        delete("/groups/#{id}/members", params)
      end
      
      # Remove all members from all active member groups as a background job. The member_status_id parameter must be set.
      def remove_all_members_from_groups(id, params = {})
        delete("/groups/#{id}/members/remove", params)
      end
      
      # Copy all the users of one group into another group.
      def copy_members_to_different_group(from_id, to_id, params = {})
        put("/groups/#{from_id}/#{to_id}/members/copy", params)
      end
    end
  end
end