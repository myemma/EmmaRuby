# @see http://api.myemma.com/api/external/members.html

module Emma
  module API
    module Members
      # Get detailed information on a particular member, including all custom fields.
      def get_member_by_id(id, params = {})
        get("/members/#{id}", params)
      end

      # Get a basic listing of all members in an account.
      def my_members(params = {})
        get("/members", params)
      end

      # Get detailed information on a particular member, including all custom fields, by email address instead of ID.
      def get_member_by_email(email, params = {})
        get("/members/email/#{email}", params)
      end

      # If a member has been opted out, returns the details of their optout, specifically date and mailing_id.
      def get_optout_member(id)
        get("/members/#{id}/optout")
      end

      # Update a member’s status to optout keyed on email address instead of an ID.
      def optout(email)
        put("/members/email/optout/#{email}")
      end

      # Add new members or update existing members in bulk. If you are doing actions for a single member please see the add_member() call below.
      def add_members(params = {})
        post("/members", params)
      end

      # Adds or updates a single audience member. If you are performing actions on bulk members please use the add_members() call above.
      def add_member(params = {})
        post("/members/add", params)
      end

      # Adds member and triggers the opt-out workflow. Use when you want to send a confirmation email.
      def add_member_signup(params = {})
        post("/members/signup", params)
      end

      # Delete an array of members.
      def remove_members(params = {})
        put("/members/delete", params)
      end

      # Change the status for an array of members.
      def change_members_status(params = {})
        put("/members/status", params)
      end

      # Update a single member’s information.
      def update_member(id, params = {})
        put("/members/#{id}", params)
      end

      # Delete the specified member.
      def remove_member(id)
        delete("/members/#{id}")
      end

      # Get the groups to which a member belongs.
      def get_members_groups(id)
        get("/members/#{id}/groups")
      end

      # Add a single member to one or more groups.
      def add_member_to_groups(id, params)
        put("/members/#{id}/groups", params)
      end

      # Remove a single member from one or more groups.
      def remove_member_from_groups(id, params)
        put("/members/#{id}/groups/remove", params)
      end

      # Delete all members.
      def remove_all_members
        delete("/members")
      end

      # Remove the specified member from all groups.
      def remove_member_from_all_groups(id)
        delete("/members/#{id}/groups")
      end

      # Remove multiple members from groups.
      def remove_multiple_members_from_groups(params = {})
        put("/members/groups/remove", params)
      end

      # Get the entire mailing history for a member.
      def get_mailing_history_for_member(id)
        get("/members/#{id}/mailings")
      end

      # Get a list of members affected by this import.
      def imported_members(import_id)
        get("/members/imports/#{import_id}/members")
      end

      # Get information and statistics about this import.
      def import_stats(import_id)
        get("/members/imports/#{import_id}")
      end

      # Get information about all imports for this account.
      def my_imports
        get("/members/imports")
      end

      # Update an import record to be marked as ‘deleted’.
      def delete_import
        delete("/members/imports/delete")
      end

      # Copy all account members of one or more statuses into a group.
      def copy_members_to_group(group_id, params = {})
        put("/members/#{group_id}/copy", params)
      end

      # Update the status for a group of members, based on their current
      # status. Valid statuses id are (‘a’,’e’, ‘f’, ‘o’) active, error, forwarded, optout.
      def update_group_members_status(status_from, status_to, group_id = nil)
        params = {}
        params[:group_id] = group_id unless group_id.nil?
        put("/members/status/#{status_from}/to/#{status_to}", params)
      end
    end
  end
end