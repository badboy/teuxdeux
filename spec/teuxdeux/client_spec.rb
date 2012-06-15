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
end
