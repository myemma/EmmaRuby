require_relative 'helper'

class TestEmmaInterface < Test::Unit::TestCase
  
  context "attributes" do
    setup do
      @_env_account_id = ENV['EMMA_ACCOUNT_ID']
      @_env_public_key = ENV['EMMA_PUBLIC_KEY']
      @_env_private_key = ENV['EMMA_PRIVATE_KEY']

      ENV.delete 'EMMA_ACCOUNT_ID'
      ENV.delete 'EMMA_PUBLIC_KEY'
      ENV.delete 'EMMA_PRIVATE_KEY'

      @account_id = '12345678'
      @pub_key = 'test_public_key'
      @private_key = 'test_private_key'
      @debug = true
    end

    teardown do
      ENV['EMMA_ACCOUNT_ID'] = @_env_account_id
      ENV['EMMA_PUBLIC_KEY'] = @_env_public_key
      ENV['EMMA_PRIVATE_KEY'] = @_env_private_key
    end
    
    should "No API due to no Account ID" do
      @em = Emma::Setup.new
      assert_equal nil, @em.account_id
    end
    
    should "No API due to no Pub Key" do
      @em = Emma::Setup.new(@account_id)
      assert_equal nil, @em.public_key
    end
    
    should "No API due to no Private Key" do
      @em = Emma::Setup.new(@account_id, @public_key)
      assert_equal nil, @em.private_key
    end
    
    should "set the Account ID via the setter" do
      @em = Emma::Setup.new
      @em.account_id = @account_id
      assert_equal @account_id, @em.account_id
    end
    
    should "set the Public Key via the setter" do
      @em = Emma::Setup.new
      @em.public_key = @pub_key
      assert_equal @pub_key, @em.public_key
    end
    
    should "set the Private Key via the setter" do
      @em = Emma::Setup.new
      @em.private_key = @private_key
      assert_equal @private_key, @em.private_key
    end
    
    should "turn on debug mode via the setter" do
      @em = Emma::Setup.new
      @em.debug = @debug
      assert_equal @debug, @em.debug
    end
    
    should "set the Account ID via the Environment variable" do
      ENV['EMMA_ACCOUNT_ID'] = @account_id
      @em = Emma::Setup.new
      assert_equal @account_id, @em.account_id
      ENV.delete 'EMMA_ACCOUNT_ID'
    end
    
    should "set the Public Key via the Environment variable" do
      ENV['EMMA_PUBLIC_KEY'] = @public_key
      @em = Emma::Setup.new
      assert_equal @public_key, @em.public_key
      ENV.delete 'EMMA_PUBLIC_KEY'
    end
    
    should "set the Private Key via the Environment variable" do
      ENV['EMMA_PRIVATE_KEY'] = @private_key
      @em = Emma::Setup.new
      assert_equal @private_key, @em.private_key
      ENV.delete 'EMMA_PRIVATE_KEY'
    end
  end

end