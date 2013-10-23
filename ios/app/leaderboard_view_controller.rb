class LeaderboardViewController < UITableViewController
  def leaders
    @leaders ||= []
  end

  def leaders=(leaders)
    @leaders = leaders
    self.tableView.reloadData
  end

  def viewDidLoad
  end

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

  def tableView(tableView, numberOfRowsInSection:section)
    leaders.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('LeaderboardCell')

    cell.textLabel.text = User.splitIdentifier(leaders[indexPath.row].first)
    cell.detailTextLabel.text = leaders[indexPath.row].last.to_s

    cell
  end

end
