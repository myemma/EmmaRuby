require_relative 'helper'

class TestEmmaMethods < Test::Unit::TestCase
  
  context "testing of methods" do
    setup do
      @em = Emma::Setup.new(nil, nil, nil, true)
      @member_id = '111'
      @member_email = 'dennismonsewicz@gmail.com'
    end
    
    teardown do
      @em = nil
      @member_id = nil
      @member_email = nil
    end
    
    context "testing of methods involving calls to the members endpoints" do
      should "return member array list" do
        VCR.use_cassette('members/list_of_members') do
          response = @em.my_members
          assert_instance_of Array, response
        end
      end

      should "lookup member by id" do
        VCR.use_cassette('members/single_member') do
          response = @em.get_member_by_id(@member_id)
          assert response.has_key?('error')
        end
      end

      should "lookup member by email" do
        VCR.use_cassette('members/single_member_by_email') do
          response = @em.get_member_by_email(@member_email)
          assert response.has_key?('error')
        end
      end

      should "lookup return opted out member" do
        VCR.use_cassette('members/single_member_optout_info') do
          response = @em.get_optout_member(@member_id)
          assert_instance_of Array, response
        end
      end

      should "optout member" do
        VCR.use_cassette('members/optout_member') do
          response = @em.optout(@member_email)
          assert response.has_key?('error')
        end
      end

      should "add new members" do
        VCR.use_cassette('members/add_new_members') do
          response = @em.add_members(:members => [ {:email => "dennismonsewicz+22211@gmail.com"}, {:email => "dennismonsewicz+kliwuu11@gmail.com"} ])
          assert response.has_key?('import_id')
        end
      end

      should "add new member" do
        VCR.use_cassette('members/add_single_member') do
          response = @em.add_member(:email => 'dennismonsewicz+ldflwj@gmail.com', :fields => { :first_name => "dennis", :last_name => "the test" })
          assert response.has_key?('member_id')
        end
      end

      should "remove an array of members" do
        VCR.use_cassette('members/remove_array_of_members') do
          response = @em.remove_members(:member_ids => [123, 111])
          assert_equal true, response
        end
      end

      should "change the status of an array of members" do
        VCR.use_cassette('members/change_status_for_array_of_members') do
          response = @em.change_members_status(:member_ids => [123, 111], :status_to => "a")
          assert_equal true, response
        end
      end

      should "update a single member" do
        VCR.use_cassette('members/update_member') do
          response = @em.update_member(111, :status_to => "e")
          assert response.has_key?('error')
        end
      end

      should "remove a member" do
        VCR.use_cassette('members/remove_member') do
          response = @em.remove_member(111)
          assert response.has_key?('error')
        end
      end

      should "get a member's groups" do
        VCR.use_cassette('members/members_groups') do
          response = @em.get_members_groups(111)
          assert response.has_key?('error')
        end
      end

      should "add single member to a list of groups" do
        VCR.use_cassette('members/add_member_to_groups') do
          response = @em.add_member_to_groups(111, :group_ids => [150, 151])
          assert response.has_key?('error')
        end
      end

      should "remove a member from groups" do
        VCR.use_cassette('members/remove_member_from_groups') do
          response = @em.remove_member_from_groups(111, :group_ids => [150, 151])
          assert response.has_key?('error')
        end
      end

      should "remove all members tied to account" do
        VCR.use_cassette('members/remove_all_members') do
          response = @em.remove_all_members
          assert_equal true, response
        end
      end

      should "remove member from all groups" do
        VCR.use_cassette('members/remove_member_from_groups') do
          response = @em.remove_member_from_all_groups(111)
          assert response.has_key?('error')
        end
      end

      should "remove multiple members from groups" do
        VCR.use_cassette('members/remove_multiple_members_from_groups') do
          response = @em.remove_multiple_members_from_groups(:group_ids => [151], :member_ids => [202])
          assert_equal true, response
        end
      end

      should "get mailing history for member" do
        VCR.use_cassette('members/imported_members') do
          response = @em.get_mailing_history_for_member(111)
          assert_instance_of Array, response
        end
      end

      should "get list of members by import id" do
        VCR.use_cassette('members/import_stats') do
          response = @em.import_stats(111)
          assert response.has_key?('error')
        end
      end

      should "get information on all imports" do
        VCR.use_cassette('members/my_imports') do
          response = @em.my_imports
          assert_instance_of Array, response
        end
      end

      should "delete an import" do
        VCR.use_cassette('members/delete_import') do
          response = @em.delete_import
          assert response.has_key?('error')
        end
      end

      should "copy members to group" do
        VCR.use_cassette('members/copy_members_to_group') do
          response = @em.copy_members_to_group(111, :member_status_id => ["a"])
          assert response.has_key?('error')
        end
      end

      should "update group members' status" do
        VCR.use_cassette('members/update_group_members_status') do
          response = @em.update_group_members_status('e', 'a', 111)
          assert response
        end
      end
    end
    
    context "testing of methods involving calls to field endpoints" do
      should "return field array list" do
        VCR.use_cassette('fields/list_of_fields') do
          response = @em.my_fields
          assert_instance_of Array, response
        end
      end
      
      should "lookup field by id" do
        VCR.use_cassette('fields/single_field') do
          response = @em.get_field_by_id(111)
          assert response.has_key?('error')
        end
      end
      
      should "add new field" do
        VCR.use_cassette('fields/add_field') do
          response = @em.add_field :shortcut_name => "my_new_field_#{random_string}", :column_order => 1, :display_name => "My New Field (#{random_string})", :field_type => "text"
          assert_instance_of Fixnum, response
        end
      end
      
      should "remove field" do
        VCR.use_cassette('fields/remove_field') do
          response = @em.remove_field 111
          assert response.has_key?('error')
        end
      end
      
      should "clear member data for field" do
        VCR.use_cassette('fields/remove_member_data_for_field') do
          response = @em.remove_member_data_for_field 111
          assert response
        end
      end
      
      should "update field" do
        VCR.use_cassette('fields/update_field') do
          response = @em.update_field 111, :display_name => "Hello World"
          assert response.has_key?("error")
        end
      end
      
    end
    
    context "testing of methods involving calls to groups endpoints" do
      should "return group array list" do
        VCR.use_cassette('groups/my_groups') do
          response = @em.my_groups
          assert_instance_of Array, response
        end
      end
      
      should "create new groups" do
        VCR.use_cassette('groups/add_new_groups') do
          response = @em.add_new_groups :groups => [ {:group_name => "My New Group"} ]
          assert_instance_of Array, response
        end
      end
      
      should "get group by id" do
        VCR.use_cassette('groups/get_group_by_id') do
          response = @em.get_group_by_id 111
          assert response.has_key?("error")
        end
      end
      
      should "update group" do
        VCR.use_cassette('groups/update_group') do
          response = @em.update_group 111, :group_name => "New Group Name Here"
          assert response.has_key?("error")
        end
      end
      
      should "remove group" do
        VCR.use_cassette('groups/remove_group') do
          response = @em.remove_group 111
          assert response.has_key?("error")
        end
      end
      
      should "get members in a single active group" do
        VCR.use_cassette('groups/group_members') do
          response = @em.group_members 111
          assert response.has_key?("error")
        end
      end
      
      should "add a list of members to a group" do
        VCR.use_cassette('groups/add_members_to_group') do
          response = @em.add_members_to_group 111, :member_ids => [100, 102]
          assert response.has_key?("error")
        end
      end
      
      should "remove a list of members fomr a group" do
        VCR.use_cassette('groups/remove_members_from_group') do
          response = @em.remove_members_from_group 111, :member_ids => [100, 102]
          assert response.has_key?("error")
        end
      end
      
      should "remove all members from a group" do
        VCR.use_cassette('groups/remove_all_members_from_group') do
          response = @em.remove_all_members_from_group 111
          assert response.has_key?("error")
        end
      end
      
      should "remove all members from a groups" do
        VCR.use_cassette('groups/remove_all_members_from_groups') do
          response = @em.remove_all_members_from_groups 111, :member_status_id => 'a', :delete_members => true
          assert response == true
        end
      end
      
      should "copy members from one group to another" do
        VCR.use_cassette('groups/copy_members_to_different_group') do
          response = @em.copy_members_to_different_group(111, 121, :member_status_id => ["a"])
          assert response == true
        end
      end
      
    end
    
    context "testing of methods involving calls to the mailings endpoints" do
      should "return mailings array list" do
        VCR.use_cassette('mailings/my_mailings') do
          response = @em.my_mailings
          assert_instance_of Array, response
        end
      end
      
      should "return mailing by id" do
        VCR.use_cassette('mailings/get_mailing_by_id') do
          response = @em.get_mailing_by_id 111
          assert response.has_key? "error"
        end
      end
      
      should "return list of mailing members by id" do
        VCR.use_cassette('mailings/get_mailing_members') do
          response = @em.get_mailing_members 111
          assert response.has_key? "error"
        end
      end
      
      should "return personalized message content as sent to a specific member as part of the specified mailing." do
        VCR.use_cassette('mailings/get_personalized_member_mailing') do
          response = @em.get_personalized_member_mailing 111, 102
          assert response.has_key? "error"
        end
      end
      
      should "return list of groups a mailing was sent to" do
        VCR.use_cassette('mailings/get_groups_by_mailing') do
          response = @em.get_groups_by_mailing 111
          assert response.has_key? "error"
        end
      end
      
      should "return list of searches associated to the sent mailing" do
        VCR.use_cassette('mailings/mailing_searches') do
          response = @em.mailing_searches 111
          assert response.has_key? "error"
        end
      end
      
      should "update mailing" do
        VCR.use_cassette('mailings/update_mailing') do
          response = @em.update_mailing 111, :status => 'canceled'
          assert response.has_key? "error"
        end
      end
      
      should "remove a mailing" do
        VCR.use_cassette('mailings/remove_mailing') do
          response = @em.remove_mailing 111
          assert response.has_key? "error"
        end
      end
      
      should "cancel queued mailing" do
        VCR.use_cassette('mailings/cancel_queued_mailing') do
          response = @em.cancel_queued_mailing 111
          assert response.has_key? "error"
        end
      end
      
      should "forward mailing to additional recipients" do
        VCR.use_cassette('mailings/forward_mailing_to_additional_recipients') do
          response = @em.forward_mailing_to_additional_recipients 111, 102, :recipient_emails => ["testme123@gmail.com"]
          assert response.has_key? "error"
        end
      end
      
      should "send prior mailing to additional recipients" do
        VCR.use_cassette('mailings/send_existing_mailing') do
          response = @em.send_existing_mailing 111, :recipient_emails => ["testme123@gmail.com"]
          assert response.has_key? "error"
        end
      end
      
      should "return headsup email addresses" do
        VCR.use_cassette('mailings/mailing_headsup') do
          response = @em.mailing_headsup 111
          assert response.has_key? "error"
        end
      end
      
      should "validate mailing has valid personalization-tag syntax" do
        VCR.use_cassette('mailings/validate_mailing') do
          response = @em.validate_mailing :subject => "Another Test"
          assert response == true
        end
      end
      
      should "declares winner of split test" do
        VCR.use_cassette('mailings/declare_winner_of_split_test') do
          response = @em.declare_winner_of_split_test 111, 112
          assert response.has_key? "error"
        end
      end
      
    end

    context "testing of methods involving calls to the response endpoints" do
      should "return mailing by id" do
        VCR.use_cassette('response/my_account_summary') do
          response = @em.my_account_summary
          assert_instance_of Array, response
        end
      end
      
      should "method will return the counts of each type of response activity for a particular mailing." do
        VCR.use_cassette('response/single_response_summary') do
          response = @em.single_response_summary 111
          assert response.has_key? "error"
        end
      end
      
      should "Get the list of messages by id by a particular action actions include (sends, in_progress, deliveries, opens, links, clicks, forwards, optouts, signups, shares, customer_shares, customer_share_clicks)" do
        %w(sends in_progress deliveries opens links clicks forwards optouts signups shares customer_shares customer_share_clicks).each do |action|
          VCR.use_cassette('response/response_mailing_information_' + action) do
            response = @em.response_mailing_information 111, action
            assert response.has_key? "error"
          end
        end
      end
      
      should "Get the customer share associated with the share id." do
        VCR.use_cassette('response/customer_share_information') do
          response = @em.customer_share_information 111
          assert response.has_key? "error"
        end
      end
      
      should "Get overview of shares pertaining to this mailing_id." do
        VCR.use_cassette('response/mailing_shares_overview') do
          response = @em.mailing_shares_overview 111
          assert response.has_key? "error"
        end
      end
      
    end
    
    context "testing of methods involving calls to the searches endpoints" do
      
      should "Retrieve a list of saved searches." do
        VCR.use_cassette('searches/my_searches') do
          response = @em.my_searches
          assert_instance_of Array, response
        end
      end
      
      should "Retrieve a single search." do
        VCR.use_cassette('searches/single_search') do
          response = @em.single_search 111
          assert response.has_key? "error"
        end
      end
      
      should "create a single search." do
        VCR.use_cassette('searches/create_search') do
          response = @em.create_search :name => "New Search", :criteria => [ "or", ["group", "eq", "Monthly Newsletter"]  ]
          assert_instance_of Fixnum, response
        end
      end
      
      should "update a single search." do
        VCR.use_cassette('searches/update_search') do
          response = @em.update_search 111, :name => "New Search", :criteria => [ "or", ["group", "eq", "Monthly Newsletter"]  ]
          assert response.has_key? "error"
        end
      end
      
      should "remove a single search." do
        VCR.use_cassette('searches/remove_search') do
          response = @em.remove_search 111
          assert response.has_key? "error"
        end
      end
      
      should "return list of members of search id." do
        VCR.use_cassette('searches/get_members_of_search') do
          response = @em.get_members_of_search 111
          assert response.has_key? "error"
        end
      end
      
    end
    
    context "testing of methods involving calls to the webhooks endpoints" do
      should "Retrieve a list of webhooks." do
        VCR.use_cassette('webhooks/my_webhooks') do
          response = @em.my_webhooks
          assert_instance_of Array, response
        end
      end
      
      should "Retrieve single webhook." do
        VCR.use_cassette('webhooks/get_webhook') do
          response = @em.get_webhook 111
          assert response.has_key? "error"
        end
      end
      
      should "Retrieve webhook events list." do
        VCR.use_cassette('webhooks/webhook_events') do
          response = @em.webhook_events 111
          assert response.has_key? "error"
        end
      end
      
      should "Add webhook" do
        VCR.use_cassette('webhooks/add_webhook') do
          response = @em.add_webhook :url => "http://www.google.com", :event => "mailing_finish"
          assert_instance_of Fixnum, response
        end
      end
      
      should "update webhook" do
        VCR.use_cassette('webhooks/update_webhook') do
          response = @em.update_webhook 111, :url => "http://www.yahoo.com"
          assert response.has_key? "error"
        end
      end
      
      should "delete webhook" do
        VCR.use_cassette('webhooks/remove_webhook') do
          response = @em.remove_webhook 111
          assert response.has_key? "error"
        end
      end
      
      should "remove all webhooks" do
        VCR.use_cassette('webhooks/remove_all_webhooks') do
          response = @em.remove_all_webhooks
          assert response == true
        end
      end
      
    end
  
    context "testing of methods involving calls to the triggers endpoints" do
      
      should "Retrieve a list of triggers." do
        VCR.use_cassette('triggers/my_triggers') do
          response = @em.my_triggers
          assert_instance_of Array, response
        end
      end
      
      should "Add a trigger." do
        VCR.use_cassette('triggers/add_trigger') do
          response = @em.add_trigger :parent_mailing_id => 111, :name => "test", :event_type => "c", :object_ids => [100, 102]
          assert response.has_key? "error"
        end
      end
      
      should "Look up a trigger by trigger id.." do
        VCR.use_cassette('triggers/get_trigger_by_id') do
          response = @em.get_trigger_by_id 111
          assert response.has_key? "error"
        end
      end
      
      should "Update trigger." do
        VCR.use_cassette('triggers/update_trigger') do
          response = @em.update_trigger 111, :name => "Another test mailing update"
          assert response.has_key? "error"
        end
      end
      
      should "Remove a trigger." do
        VCR.use_cassette('triggers/remove_trigger') do
          response = @em.remove_trigger 111
          assert response.has_key? "error"
        end
      end
      
      should "return array of mailings sent by trigger." do
        VCR.use_cassette('triggers/get_trigger_mailings') do
          response = @em.get_trigger_mailings 111
          assert response.has_key? "error"
        end
      end
      
    end
  
  end
  
  def random_string(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

end