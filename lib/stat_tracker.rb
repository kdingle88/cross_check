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

  def highest_total_score
    game_scores_sum = games.map { |game| game.total_goals}

    game_scores_sum.max
  end

  def lowest_total_score
    game_scores_sum = games.map { |game| game.total_goals}

    game_scores_sum.min
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
  
end