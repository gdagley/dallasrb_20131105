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
