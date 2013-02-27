# @see http://api.myemma.com/api/external/mailings.html

module Emma
  module API
    module Mailings
      # Get information about current mailings.
      def my_mailings(params = {})
        get("/mailings", params)
      end
      
      # Get detailed information for one mailing.
      def get_mailing_by_id(id)
        get("/mailings/#{id}")
      end
      
      # Get the list of members to whom the given mailing was sent.
      def get_mailing_members(id)
        get("/mailings/#{id}/members")
      end
      
      # Gets the personalized message content as sent to a specific member as part of the specified mailing.
      def get_personalized_member_mailing(id, member_id, params = {})
        get("/mailings/#{id}/messages/#{member_id}", params)
      end
      
      # Get the groups to which a particular mailing was sent.
      def get_groups_by_mailing(id, params = {})
        get("/mailings/#{id}/groups", params)
      end
      
      # Get all searches associated with a sent mailing.
      def mailing_searches(id, params = {})
        get("/mailings/#{id}/searches", params)
      end
      
      # Update status of a current mailing
      def update_mailing(id, params = {})
        put("/mailings/#{id}", params)
      end
      
      # Sets archived timestamp for a mailing so it is no longer included in mailing_list.
      def remove_mailing(id)
        delete("/mailings/#{id}")
      end
      
      # Cancels a mailing that has a current status of pending or paused. All other statuses will result in a 404.
      def cancel_queued_mailing(id)
        delete("/mailings/cancel/#{id}")
      end
      
      # Forward a previous message to additional recipients. If these recipients are not already in the audience, they will be added with a status of FORWARDED.
      def forward_mailing_to_additional_recipients(id, member_id, params = {})
        post("/forwards/#{id}/#{member_id}", params)
      end
      
      # Send a prior mailing to additional recipients. A new mailing will be created that inherits its content from the original.
      def send_existing_mailing(id, params = {})
        post("/mailings/#{id}", params)
      end
      
      # Get heads up email address(es) related to a mailing.
      def mailing_headsup(id)
        get("/mailings/#{id}/headsup")
      end
      
      # Validate that a mailing has valid personalization-tag syntax
      def validate_mailing(params = {})
        post("/mailings/validate", params)
      end
      
      # Declare the winner of a split test manually. In the event that the test duration has not elapsed, the current stats for each test will be frozen and the content defined in the user declared winner will sent to the remaining members for the mailing. Please note, any messages that are pending for each of the test variations will receive the content assigned to them when the test was initially constructed.
      def declare_winner_of_split_test(mailing_id, winner_id)
        post("/mailings/#{mailing_id}/winner/#{winner_id}")
      end
    end
  end
end