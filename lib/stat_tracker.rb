require 'csv'
require_relative 'game.rb'
require_relative 'team.rb'
require_relative 'game_stat.rb'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_stats 

  def initialize(games, teams, game_stats)
    @games = games
    @teams = teams
    @game_stats = game_stats
  end

  def self.from_csv(locations)

    games_data = CSV.read(locations[:games], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    teams_data = CSV.read(locations[:teams], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    game_teams_data = CSV.read(locations[:game_teams], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

    games_list = games_data.map {|d| d.to_hash}
    teams_list = teams_data.map {|d| d.to_hash}
    game_teams_list = game_teams_data.map {|d| d.to_hash}
    
    games = games_list.map {|g| Game.new(g)}
    teams = teams_list.map {|t| Team.new(t)}
    game_stats= game_teams_list.map {|l| Game_Stat.new(l)}
  
    stat_tracker = StatTracker.new(games, teams, game_stats)

    stat_tracker
  end

  #Game Statistics

  def highest_total_score
    game_scores_sum = games.map { |game| game.total_goals}

    game_scores_sum.max
  end

  def lowest_total_score
    game_scores_sum = games.map { |game| game.total_goals}

    game_scores_sum.min
  end

  def biggest_blowout
    game_scores_difference = games.map { |game| game.difference_goals}

    game_scores_difference.max
  end

  def percentage_home_wins
    home_wins = total_home_wins / games.length.to_f

    home_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = total_visitor_wins / games.length.to_f

    visitor_wins.round(2)
  end

  def count_of_games_by_season
    season_count = Hash.new 0

    games.each do |game|
      season_count[game.season] += 1
    end

    season_count
  end

  def average_goals_per_game
    
    total_goals_scored = games.reduce(0) {|sum, game| sum + game.total_goals }

    avg_goals = total_goals_scored / games.length.to_f

    avg_goals.round(2)
  end

  def average_goals_by_season
    avg_goal = Hash.new

    goal_count = count_of_goals_by_season

    season_count = count_of_games_by_season

    season_count.each do |season, count|
        season_avg = goal_count[season] / count.to_f
      avg_goal[season] = season_avg.round(2)
    end
    avg_goal
  end

  #League Statistics

  def count_of_teams
    teams.length
  end

  def best_offense

    highest_goals = count_of_goals_by_team.key(count_of_goals_by_team.values.max)

    best_o = teams.select {|team| team.team_id == highest_goals}

    best_o[0].team_name
    
  end

  def worst_offense

    lowest_goals = count_of_goals_by_team.key(count_of_goals_by_team.values.min)

    worst_o = teams.select {|team| team.team_id == lowest_goals}

    worst_o[0].team_name
  end

  def best_defense
    selected_team = teams[0]
    teams.each do |team|
      team.goals_allowed(games) < selected_team.goals_allowed(games) ? selected_team = team : selected_team
    end
    selected_team.team_name
  end

  def worst_defense
    selected_team = teams[0]
    teams.each do |team|
      team.goals_allowed(games) > selected_team.goals_allowed(games) ? selected_team = team : selected_team
    end
    selected_team.team_name
  end

  def highest_scoring_visitor
    visitor_scores = teams.map {|team| team.away_goals(games)}

    hi_score_visitor = teams.select {|team| team.away_goals(games) == visitor_scores.max}

    hi_score_visitor[0].team_name
  end
  
  def highest_scoring_home_team
    home_scores = teams.map {|team| team.home_goals(games)}

    hi_score_homer = teams.select {|team| team.home_goals(games) == home_scores.max}

    hi_score_homer[0].team_name
  end

  def lowest_scoring_visitor
    visitor_scores = teams.map {|team| team.away_goals(games)}

    low_score_visitor = teams.select {|team| team.away_goals(games) == visitor_scores.min}

    low_score_visitor[0].team_name
  end

  def lowest_scoring_home_team
    home_scores = teams.map {|team| team.home_goals(games)}

    low_score_homer = teams.select {|team| team.home_goals(games) == home_scores.min}

    low_score_homer[0].team_name
  end

  def winningest_team
    team_win_pct = teams.map {|team| team.win_percentage(game_stats)}

    winning_team = teams.find {|team| team.win_percentage(game_stats) == team_win_pct.max} 

    winning_team.team_name

  end

  def best_fans
    teams_pct_diff = teams.map {|team| team.home_win_percentage(game_stats) - team.away_win_percentage(game_stats)}

    team_with_best_fans = teams.find { |team| team.home_win_percentage(game_stats) == teams_pct_diff.max }

    team_with_best_fans.team_name
  end

  def worst_fans
    worst_teams =teams.select {|team| team.home_win_percentage(game_stats) < team.away_win_percentage(game_stats)}
    
    worst_teams
  end

  #Team Statistics

  def team_info(team_id)
    selected_team = teams.find {|team| team.team_id == team_id}

    {
      team_id: selected_team.team_id,
      franchise_id: selected_team.franchise_id,
      short_name: selected_team.short_name,
      team_name: selected_team.team_name,
      abbreviation: selected_team.abbreviation,
      link: selected_team.link
    }
  end

def best_season(team_id)

end


  private

  def total_home_wins

    teams.reduce(0) {|sum, team| sum + team.home_team_wins(game_stats).length}
  end

  def total_visitor_wins
    visitor_winners = games.select {|game| game.outcome == "away win REG"}

    visitor_winners.length
  end

  def count_of_goals_by_season
    goal_count = Hash.new 0

    games.each do |game|
      goal_count[game.season] += game.total_goals
    end

    goal_count
  end

  def count_of_goals_by_team
    team_goal_count = Hash.new 0

    game_stats.each do |stat|
      team_goal_count[stat.team_id] += stat.goals
    end

    team_goal_count
  end

  def total_num_of_seasons
    count_of_games_by_season.length
  end

end