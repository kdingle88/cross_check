require 'csv'
require_relative 'game.rb'
require_relative 'team.rb'
require_relative 'game_stat'
require_relative 'game_stats_repo.rb'
require_relative 'games_repo.rb'
require_relative 'teams_repo.rb'
require 'pry'

class StatTracker
  attr_reader :games_repo, :teams_repo, :game_stats_repo

  def initialize(games, teams, game_stats)
    @games_repo = GamesRepo.new(self,games)
    @teams_repo = TeamsRepo.new(self, teams)
    @game_stats_repo = GameStatsRepo.new(self, game_stats)
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
    game_stats= game_teams_list.map {|l| GameStat.new(l)}
  
    stat_tracker = StatTracker.new(games, teams, game_stats)

    stat_tracker
  end

  #Game Statistics

  def highest_total_score
    GamesRepo.highest_total_score(games)
  end

  def lowest_total_score
    GamesRepo.lowest_total_score(games)
  end

  def biggest_blowout
    GamesRepo.biggest_blowout(games)
  end

  def percentage_home_wins
    GamesRepo.percentage_home_wins(games)
  end

  def percentage_visitor_wins
    GamesRepo.percentage_visitor_wins(games)
  end

  def count_of_games_by_season
    GamesRepo.count_of_games_by_season(games)
  end

  def average_goals_per_game
    GamesRepo.average_goals_per_game(games)
  end

  def average_goals_by_season
    GamesRepo.average_goals_by_season(games)
  end

  #League Statistics

  def count_of_teams
    TeamsRepo.count_of_teams(teams)
  end

  def best_offense
    #the repo the answer should be . the method . the result
    teams_repo.best_offense.team_name
    
  end

  def worst_offense
    teams_repo.worst_offense.team_name
  end

  def best_defense
    teams_repo.best_defense.team_name
  end

  def worst_defense
    teams_repo.worst_defense.team_name
  end

  def highest_scoring_visitor
    teams_repo.highest_scoring_visitor.team_name
  end

  def highest_scoring_home_team
    teams_repo.highest_scoring_home_team.team_name
  end

  def lowest_scoring_visitor
    teams_repo.lowest_scoring_visitor.team_name
  end

  def lowest_scoring_home_team
    teams_repo.lowest_scoring_home_team.team_name
  end

  def winningest_team
    teams_repo.winningest_team.team_name
  end
  
  def best_fans
    teams_repo.best_fans.team_name
  end

  def worst_fans
    teams_repo
      .worst_fans
      .map(&:team_name)
  end

  #Team Statistics


  def team_info(team_id)
    teams_repo.team_info(team_id)
  end

  def best_season(team_id)
    games_repo.best_season(team_id)
  end

  def worst_season(team_id)
    games_repo.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    games_repo.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    game_stats_repo.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    game_stats_repo.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    teams_repo.favorite_opponent(team_id).name
  end

  def rival(team_id)
    teams_repo.rival(team_id).name
  end

  def biggest_team_blowout(team_id)
    games_repo.biggest_blowout(team_id)
  end

  def worst_loss(team_id)
    games_repo.worst_loss
  end




  #Other Methods

  def team_id_with_highest_average_of_goals_per_game 
    game_stats_repo.team_id_with_highest_number_of_goals_per_game
  end

  def team_id_with_lowest_average_of_goals_per_game
    game_stats_repo.team_id_with_lowest_number_of_goals_per_game
  end

  def team_id_with_lowest_number_of_goals_allowed_per_game
    games_repo.team_id_with_lowest_number_of_goals_allowed_per_game
  end

  def team_id_with_highest_number_of_goals_allowed_per_game
    games_repo.team_id_with_highest_number_of_goals_allowed_per_game
  end

  def team_id_with_highest_score_per_game_when_away
    games_repo.team_id_with_highest_score_per_game_when_away
  end

  def team_id_with_highest_score_per_game_when_home
    games_repo.team_id_with_highest_score_per_game_when_home
  end

  def team_id_with_lowest_score_per_game_when_away
    games_repo.team_id_with_lowest_score_per_game_when_away
  end

  def team_id_with_lowest_score_per_game_when_home
    games_repo.team_id_with_lowest_score_per_game_when_home
  end

  def team_id_with_highest_percent_wins
    game_stats_repo.team_id_with_highest_percent_wins
  end

  def team_id_with_lowest_percent_wins
    game_stats_repo.team_id_with_lowest_percent_wins
  end

  def team_id_with_biggest_difference_in_home_away_wins
    games_repo.team_id_with_biggest_difference_in_home_away_wins
  end

  def array_of_team_ids_with_better_away_records
    games_repo.array_of_team_ids_with_better_away_records
  end

  def team_id_lowest_win_percentage_against_the_given_team(team_id)
    games_repo.team_id_lowest_win_percentage_against_the_given_team(team_id)
  end

  def team_id_highest_win_percentage_against_the_given_team(team_id)
    games_repo.team_id_highest_win_percentage_against_the_given_team(team_id)
  end

  def games_won_by_given_team(team_id)
    game_stats_repo.games_won_by_given_team(team_id)
  end

  def games_lost_by_given_team(team_id)
    game_stats_repo.games_lost_by_given_team(team_id)
  end




  private

  def total_visitor_wins
    visitor_winners = games.select {|game| game.outcome == "away win REG"}

    visitor_winners.length
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
