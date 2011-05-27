# encoding: utf-8

require 'helper'

describe TeuxDeux do
  describe ".client" do
    it "should be a TeuxDeux::Client" do
      TeuxDeux.client.should be_a TeuxDeux::Client
    end
  end
end
