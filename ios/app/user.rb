class User
  def self.pokes
    App::Persistence['pokes'] || 0
  end

  def self.pokes=(pokes)
    App::Persistence['pokes'] = pokes
  end

  def self.identifier
    UIDevice.currentDevice.identifierForVendor.UUIDString
  end

  def self.displayIdentifier
    splitIdentifier(identifier)
  end

  def self.splitIdentifier(identifier)
    identifier.split('-').first
  end
end
