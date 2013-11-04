<!SLIDE subsection>
# The Server #
![Grape](grape_logo.png)

## Grape
[https://github.com/intridea/grape](https://github.com/intridea/grape)

<!SLIDE small>
# What is Grape? #

Grape is a REST-like API micro-framework for Ruby

    @@@ ruby
    class Foo < Grape::API
      format :json

      resource :foo do

        # GET /foo/bar
        desc "Return a public timeline."
        get :bar do
          #do something
        end

      end
    end

<!SLIDE bullets incremental>
# Why not... #

* [Rails](https://github.com/rails/rails)
* [Rails API gem](https://github.com/rails-api/rails-api)
* [Sinatra](http://www.sinatrarb.com/)
