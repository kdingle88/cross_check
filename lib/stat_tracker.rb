require 'csv'
require_relative 'game.rb'
require_relative 'team.rb'
require_relative 'game_stat.rb'

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

  private

  def total_home_wins
    winners_ot = games.select { |game| game.outcome == "home win OT" }

    winners_reg = games.select {|game| game.outcome == "home win REG"}

    winners_ot.length + winners_reg.length
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