require 'simplecov'
SimpleCov.start do
  add_group 'TeuxDeux', 'lib/teuxdeux'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end
require 'teuxdeux'
require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def stub_delete(url)
  stub_request(:delete, teuxdeux_url(url))
end

def stub_get(url)
  stub_request(:get, teuxdeux_url(url))
end

def stub_post(url)
  stub_request(:post, teuxdeux_url(url))
end

def stub_put(url)
  stub_request(:put, teuxdeux_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def teuxdeux_url(url)
  if url=~ /^http/
    url
  elsif @client && @client.authenticated?
    "https://badboy:secret@teuxdeux.com/api/#{url}"
  else
    "https://teuxdeux.com/api/#{url}"
  end
end
