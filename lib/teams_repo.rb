require 'pry'

class TeamsRepo 

  def initialize(stat_tracker, teams)
    @stat_tracker = stat_tracker
    @teams = teams
  end

  class << self
    def count_of_teams(teams)
      teams.length
    end
  end

  def best_offense
    found_team = teams
      .find {|team| team.team_id == stat_tracker.team_id_with_highest_number_of_goals_per_game }
      
    found_team

  end

  def worst_offense
    teams
      .find {|team| team.team_id == stat_tracker.team_id_with_lowest_number_of_goals_per_game }
  end

  def best_defense
    teams 
      .find {|team| team.team_id == stat_tracker.team_id_with_lowest_number_of_goals_allowed_per_game}
  end

  def worst_defense
    teams 
      .find {|team| team.team_id == stat_tracker.team_id_with_highest_number_of_goals_allowed_per_game}
  end

  def highest_scoring_visitor
    teams
      .find { |team| team.team_id == stat_tracker.team_id_with_highest_score_per_game_when_away}
  end

  def highest_scoring_home_team
    teams
      .find { |team| team.team_id == stat_tracker.team_id_with_highest_score_per_game_when_home}
  end

  def lowest_scoring_visitor
    teams
      .find { |team| team.team_id == stat_tracker.team_id_with_lowest_score_per_game_when_away}
  end

  def lowest_scoring_home_team
    teams
      .find { |team| team.team_id == stat_tracker.team_id_with_lowest_score_per_game_when_home}
  end
  
end

