require 'time'
require 'hashie'

module Vindi
  class Base < ::Hashie::Mash


   protected

    def self.parse(response)
      return self.new(response) unless reponse_has_key?
      self.new(response[key_parser])
    end

    def self.key_parser
      resource_name
    end

    # @return [String] returns the resource class name pluralized
    def self.normalize_resource_name
      Normalizer.new(resource_name).pluralize.to_s
    end

    # @return [String] returns the resource class name singular
    def self.resource_name
      Normalizer.new(self.name).demodulize.underscore.to_s
    end

    # @return [False] checks if the resoruce response key parser
    def self.reponse_has_key?
      true
    end
    
    def method_missing(message, *args, &block)
      if message =~ /(.*)_time$/
        time_string = send($1)
        Time.parse(time_string) if time_string
      else
        super
      end
    end

  end
end
