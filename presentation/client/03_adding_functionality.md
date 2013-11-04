<!SLIDE smallest>
# Adding functionality with BubbleWrap#

> "Cocoa wrappers and helpers for RubyMotion (Ruby for iOS) - Making Cocoa APIs more Ruby like, one API at a time." - [https://github.com/rubymotion/BubbleWrap](https://github.com/rubymotion/BubbleWrap)

    @@@ ruby
    # Gemfile
    gem 'bubble-wrap'

    # app/poke_view_controller.rb
    class PokeViewController < UIViewController
      extend IB

      outlet :pokeLabel
      outlet :identifierLabel

      def viewDidLoad
        pokeLabel.text = User.pokes.to_s
        identifierLabel.text = User.displayIdentifier
      end

      def poke
        data = {:udid => User.identifier}
        BW::HTTP.post("http://localhost:9292/poke", {payload: data}) do |response|
          if response.ok?
            json = BW::JSON.parse(response.body.to_str)
            User.pokes = json['pokes']
            pokeLabel.text = User.pokes.to_s
          else
            App.alert(response.error_message)
          end
        end
      end
    end

<!SLIDE smallest>
# Using Existing Obj-C Libraries with Cocoapods #

    @@@ ruby
    # Gemfile
    gem 'motion-cocoapods'

    # Rakefile
    Motion::Project::App.setup do |app|
      ...

      app.pods do
        pod 'SVProgressHUD'
      end
    end

    # app/leaderboard_view_controller.rb
    class LeaderboardViewController < UITableViewController
      attr_accessor :leaders

      def viewDidAppear(animated)
        SVProgressHUD.showWithStatus('Loading...', maskType:SVProgressHUDMaskTypeClear)
        BW::HTTP.get("http://localhost:9292/leaderboard") do |response|
          SVProgressHUD.dismiss
          if response.ok?
            json = BW::JSON.parse(response.body.to_str)
            self.leaders = json['leaders']
          else
            App.alert(response.error_message)
          end
        end
      end
    end
