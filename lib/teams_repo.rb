require 'pry'

class TeamsRepo 

  attr_reader :stat_tracker, :teams

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

  def worst_fans
    teams
      .select {|team| stat_tracker.array_of_team_ids_with_better_away_records.include?(team.team_id)}
  end

  def team_info(team_id)
    selected_team = teams.find {|team| team.team.id == team_id  }

    {
      team_id: selected_team.team_id,
      franchise_id: selected_team.franchise_id,
      short_name: selected_team.short_name,
      team_name: selected_team.team_name,
      abbreviation: selected_team.abbreviation,
      link: selected_team.link
    }

    def favorite_opponent(team_id)
      teams
        .find {|team| team.team_id == stat_tracker.team_id_lowest_win_percentage_against_the_given_team}
    end

    def rival(team_id)
      teams
        .find {|team| team.team_id == stat_tracker.team_id_highest_win_percentage_against_the_given_team}
    end

  
end

