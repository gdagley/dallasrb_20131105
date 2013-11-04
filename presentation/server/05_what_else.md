<!SLIDE smaller>
# What Else Can We Do? #

## Databases
* (MySQL, Postgres) via ActiveRecord (or others)
* Memcache, Redis, etc

## Rack Middleware

    @@@ ruby
    app = Rack::Builder.new do
      map '/api'  { run Poker::API }
      map '/'     { run Vienna }
    end

    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    use Airbrake::Rack
    use Rack::Printout

    run app

## Rake, Guard, etc.
