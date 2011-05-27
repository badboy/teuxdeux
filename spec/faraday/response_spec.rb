# encoding: utf-8

require 'helper'

describe Faraday::Response do
  before do
    @client = TeuxDeux::Client.new
  end

  {
    401 => TeuxDeux::Unauthorized,
    404 => TeuxDeux::NotFound,
    500 => TeuxDeux::InternalServerError,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('user.json').
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.user
        end.should raise_error(exception)
      end
    end
  end
end
