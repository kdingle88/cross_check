require 'pry'

class TeamsRepo 

  attr_reader :stat_tracker :teams

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

  def winningest_team
    teams
      .find {|team| team.team_id == stat_tracker.team_id_with_highest_total_wins}
  end

  def best_fans 
    teams
      .find {|team| team.team_id == stat_tracker.team_id_with_biggest_difference_in_home_away_wins}
  end
  
end

