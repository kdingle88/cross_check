require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams 
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @games_teams = game_teams
  end

  def self.from_csv(locations)

    games_data = CSV.read(locations[:games], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    teams_data = CSV.read(locations[:teams], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    game_teams_data = CSV.read(locations[:game_teams], { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

    games = games_data.map {|d| d.to_hash}
    teams = teams_data.map {|d| d.to_hash}
    game_teams = game_teams_data.map {|d| d.to_hash}
    

    stat_tracker = StatTracker.new(games, teams, game_teams)

    stat_tracker
  end
  
end