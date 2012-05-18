require "net/http"
require "json"

module REST
    module API
        module Base
            attr_accessor :base_url

            def url(path)
                raise "You need to set the base_url!" unless @base_url
                URI.parse(@base_url + path)
            end

            def GET(path)
                data = Net::HTTP.get_response(self.url(path)).body
                REST::API::Wrapper.json(data)
            end

            def POST(path, body)
                response = Net::HTTP.post_form(self.url(path), {body.to_json => ""})
                REST::API::Wrapper.json(response.body)
            end
        end

        class Wrapper
            def initialize(values)
                @values = values
            end

            def self.json(data)
                parsed = JSON.parse(data)
                if parsed.instance_of?(Array)
                    parsed.map do |item|
                        self.new(item)
                    end
                else
                    self.new(parsed)
                end
            end

            def method_missing(*args)
                if args.size == 1
                    key = args[0].to_s
                    if @values.has_key?(key)
                        return @values[key]
                    end
                end
            end

            def as_json(options={})
                @values
            end
        end
    end
end

