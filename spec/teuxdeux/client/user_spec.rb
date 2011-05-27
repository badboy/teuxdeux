# encoding: utf-8

require 'helper'

describe TeuxDeux::Client::User do
  before do
    @client = TeuxDeux::Client.new(:login => 'badboy', :password => 'secret')
  end

  describe ".user" do
    it "should return matching username" do
      stub_get("user.json").
        to_return(:body => fixture("user.json"))
      users = @client.user
      users.login.should == "badboy"
    end
  end
end
