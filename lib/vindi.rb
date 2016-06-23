require "vindi/version"
require "vindi/uri"
require 'vindi/request'
require 'vindi/api/list'
require 'vindi/api/create'
require 'vindi/api/delete'
require 'vindi/api/update'
require 'vindi/api/get'
require 'vindi/base'
require 'vindi/charge'
require 'vindi/customer'
require 'vindi/payment_profile'
require 'vindi/product'
require 'vindi/payment_method'
require 'vindi/bill'
require 'vindi/response_validator'
require 'vindi/error'
require 'vindi/normalizer'
require 'vindi/transaction'

# main module
module Vindi
  # configuration module for Vindi:
  # This enables the following to work:
  # => Vindi.configure { |vindi| vindi.api_key = 'api_key' }
  module Configuration
    attr_accessor :api_key

    def configure
      yield self
    end
  end

  extend Configuration

  def self.const_missing(const_name)
    klass = const_set(const_name, Class.new(Base))
    klass.include API::Create
    klass.include API::List
    klass.include API::Delete
    klass.include API::Update
    klass.include API::Get
  end
end
