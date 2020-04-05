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
  



  def team_id_with_highest_number_of_goals_per_game
    #need this from games repo to use in teams repo   
    game_stats_repo.team_id_with_highest_number_of_goals_per_game
  end

  def team_id_with_lowest_number_of_goals_per_game
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
  
  def highest_scoring_home_team
    home_scores = teams.map {|team| team.home_goals(games)}

    hi_score_homer = teams.select {|team| team.home_goals(games) == home_scores.max}

    hi_score_homer[0].team_name
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
