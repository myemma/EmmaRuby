# @see http://api.myemma.com/api/external/response.html

module Emma
  module API
    module Response
      # Get the response summary for an account.
      # This method will return a month-based time series of data including sends, opens, clicks, mailings, forwards, and opt-outs. 
      # Test mailings and forwards are not included in the data returned.
      def my_account_summary(params = {})
        get("/response", params)
      end
      
      # Get the response summary for a particular mailing.
      # This method will return the counts of each type of response activity for a particular mailing.
      def single_response_summary(id)
        get("/response/#{id}")
      end
      
      # Get the list of messages by id by a particular action
      # actions include (sends, in_progress, deliveries, opens, links, clicks, forwards, optouts, signups, shares, customer_shares, customer_share_clicks)
      def response_mailing_information(id, action = 'sends', params = {})
        get("/response/#{id}/#{action}", params)
      end
      
      # Get the customer share associated with the share id.
      def customer_share_information(share_id, params = {})
        get("/response/#{share_id}/customer_share", params)
      end
      
      # Get overview of shares pertaining to this mailing_id.
      def mailing_shares_overview(id)
        get("/response/#{id}/shares/overview")
      end
    end
  end
end