module Vindi
  module API
    module List
      module ClassMethods
        # This constant should not be higher than the max allowed per page
        # At the time of writing this was 50
        MAX_PER_PAGE = 50

        def list(params = {})
          resp = Request.new(:get, normalize_resource_name, params).perform
          resp[normalize_resource_name].map do |element|
            new(element)
          end
        end

        def all(params = {})
          ret = []
          page = 0
          begin
            page += 1
            last_page = list(params.merge(page: page, per_page: MAX_PER_PAGE))
            ret.concat last_page
          end while last_page.length >= MAX_PER_PAGE
          ret
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
      end
    end
  end
end
