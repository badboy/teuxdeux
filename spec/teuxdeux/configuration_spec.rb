# encoding: utf-8

require 'helper'

describe TeuxDeux::Configuration do
  describe ".configure" do
    it "should let configure all options" do
      TeuxDeux.login.should == nil

      TeuxDeux.configure do |conf|
        conf.login = "user"
      end

      TeuxDeux.login.should == "user"
    end
  end
end
