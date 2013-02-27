# @see http://api.myemma.com/api/external/searches.html

module Emma
  module API
    module Searches
      # Retrieve a list of saved searches.
      def my_searches(params = {})
        get("/searches", params)
      end
      
      # Get the details for a saved search.
      def single_search(id, params = {})
        get("/searches/#{id}", params)
      end
      
      # Create a saved search.
      def create_search(params = {})
        post("/searches", params)
      end
      
      # Update a saved search.
      # No parameters are required, but either the name or criteria parameter must be present for an update to occur.
      def update_search(id, params = {})
        put("/searches/#{id}", params)
      end
      
      # Delete a saved search. The member records referred to by the search are not affected.
      def remove_search(id)
        delete("/searches/#{id}")
      end
      
      # Get the members matching the search.
      def get_members_of_search(id)
        get("/searches/#{id}/members")
      end
    end
  end
end