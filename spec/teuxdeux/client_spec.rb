# encoding: utf-8

require 'helper'

describe TeuxDeux::Client do
  it "should work with basic auth and password" do
    stub_request(:get, "https://foo:bar@teuxdeux.com/api/user.json").
      with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => '{"id":42}', :headers => {})
    proc {
      TeuxDeux::Client.new(:login => 'foo', :password => 'bar').user
    }.should_not raise_exception
  end

  describe ".hash_to_params" do
    it "should turn a hash into url params" do
      client = TeuxDeux::Client.new

      client.hash_to_params({ :data => { :a => 1, :b => 2 }}).should == "data[a]=1&data[b]=2"

      client.hash_to_params({ :data => { :foo => { :bar => 42 }, :b => 2 }}).should == "data[b]=2&data[foo][bar]=42"

      client.hash_to_params({:data => 1}).should == "data=1"

    end
  end
end
