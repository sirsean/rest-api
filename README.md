This lets you make a simple wrapper around an HTTP service that you want to consume within your app.

For example, say you have a service with the following endpoints:

- /thing/:thing_id
- /thing/create
- /thing/:thing_id/update
- /other_thing/:other_thing_id
- /other_thing/create
- /other_thing/:other_thing_id/update

And you want to consume that service in your program. You **could** spin up HTTP requests every time you want to call them, but that'd kind of suck.

Or, you could use **rest-api**.

    module MyThings::API
        class Core
            include REST::API::Base

            attr_reader :thing, :other_thing

            def initialize
                @thing = MyThings::API::Core::Thing.new(self)
                @other_thing = MyThings::API::Core::OtherThing.new(self)
            end
        end
    end

    class MyThings::API::Core::Thing
        def initialize(api)
            @api = api
        end

        def get(thing_id)
            @api.GET("/thing/#{thing_id}")
        end

        def create(param1, param2)
            @api.POST("/thing/create", {
                "param1" => param1,
                "param2" => param2
            })
        end

        def update(thing_id, param1, param2)
            @api.POST("/thing/#{thing_id}/update", {
                "param1" => param1,
                "param2" => param2
            })
        end
    end

    class MyThings::API::Core::OtherThing
        def initialize(api)
            @api = api
        end

        def get(other_thing_id)
            @api.GET("/other_thing/#{other_thing_id}")
        end

        def create(param1, param2)
            @api.POST("/other_thing/create", {
                "param1" => param1,
                "param2" => param2
            })
        end

        def update(other_thing_id, param1, param2)
            @api.POST("/other_thing/#{other_thing_id}/update", {
                "param1" => param1,
                "param2" => param2
            })
        end
    end

To use it, you just need to instantiate your Core API class and set its base_url field (basically, that's where your service is running).

    core = MyThings::API::Core.new
    core.base_url = "http://localhost:4567"
    thing = core.thing.get(thing_id)
    puts thing.param1
    other_thing = core.other_thing.create(param1, param2)
    puts other_thing.param1

See? Easy.
