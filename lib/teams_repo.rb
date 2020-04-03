class TeamsRepo 

  
  def initialize(stat_tracker, teams)
    @stat_tracker = stat_tracker
    @teams = teams
  end

  def best_offense
    team_id = stat_tracker.highest_number_of_goals_per_game

    teams
      .find_by(&:team_id)

  end
  
end