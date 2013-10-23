class Leaderboard
  def self.reset
    @@leaderboard = nil
  end

  def self.leaderboard
    @@leaderboard ||= {}
  end

  def self.leaders
    leaderboard.to_a.sort_by {|entry| entry.last }.reverse
  end

  def self.rank(member, score)
    leaderboard[member] = score
  end

  def self.score_for(member)
    leaderboard[member] ||= 0
  end

  def self.increment(member, count = 1)
    current_score = score_for(member)
    leaderboard[member] = current_score + count
  end
end
