module Vindi
  module API
    module List

      module ClassMethods
        def list(params = {})
          resp = Request.new(:get, normalize_resource_name, params).perform
          resp[normalize_resource_name].map do |element|
            self.new(element)
          end
        end

        def all(params = {})
          ret = []
          page = 0
          begin
            page += 1
            last_page = list params.merge(page: page, per_page: 50)
            ret.concat last_page
          end while last_page.length > 0
          ret
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
      end

    end
  end
end
