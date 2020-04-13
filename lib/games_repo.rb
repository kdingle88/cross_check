class GamesRepo 

  attr_reader :stat_tracker, :games

  def initialize(stat_tracker, games)
    @stat_tracker = stat_tracker
    @games = games
  end

  def best_season(team_id)
    games
      .find_all do |game|
        game.away_team_id == team_id || game.home_team_id == team_id 
        end
      .group_by(&:season)
      .map {|season, games|  [season,win_percentage(games)]}
      .max_by {|season,win_percentage| win_percentage}[0]
  end

  def worst_season(team_id)
    games
      .find_all do |game|
        game.away_team_id == team_id || game.home_team_id == team_id 
        end 
      .group_by(&:season)
      .map {|season, games|  [season,win_percentage(games)]}
      .min_by {|season,win_percentage| win_percentage}[0]
  end

  def average_win_percentage(team_id)
    all_games_for_team_id = games.find_all do |game| 
      game.away_team_id == team_id || game.home_team_id == team_id
      end

      win_percentage(all_games_for_team_id)
      
  end

  def team_id_lowest_win_percentage_against_the_given_team(team_id)
    home_opponent_win_percentage(team_id)
    .merge(away_opponent_win_percentage(team_id)) do 
      |team_id, home_win_percentage,away_win_percentage|
      (home_win_percentage + away_win_percentage).fdiv(2)
      end
    .min_by {|team_id,percentage| percentage}[0] 
  end

  def team_id_highest_win_percentage_against_the_given_team(team_id)
    home_opponent_win_percentage(team_id)
    .merge(away_opponent_win_percentage(team_id)) do 
      |team_id, home_win_percentage,away_win_percentage|
      (home_win_percentage + away_win_percentage).fdiv(2)
      end
    .max_by {|team_id,percentage| percentage}[0] 
  end

  def biggest_team_blowout(team_id)
      games
        .find_all do|game|
          stat_tracker.games_won_by_given_team(team_id)
            .include?(game.game_id)
          end
        .map {|game| (game.home_goals - game.away_goals).abs}
        .max
  end

  def worst_loss(team_id)
      games
        .find_all do |game| 
          stat_tracker
            .games_lost_by_given_team(team_id)
            .include?(game.game_id)
          end
        .map {|game| (game.home_goals - game.away_goals).abs}
        .max
  end

  #Other Methods 

  def home_opponent_win_percentage(team_id)
    games
      .find_all { |game| game.home_team_id == team_id}
      .group_by(&:away_team_id)
      .map do |away_team_id, games| 
        total_games_played = games.length

        games_won = games
          .select {|game| game.outcome.include?("home win")}
          .length

        [away_team_id, (games_won.fdiv(total_games_played)).round(2)] 
      end
      .to_h
  end

  def away_opponent_win_percentage(team_id)
    games
      .find_all { |game| game.away_team_id == team_id}
      .group_by(&:home_team_id)
      .map do |home_team_id, games| 
        total_games_played = games.length

        games_won = games
          .select {|game| game.outcome.include?("away win")}
          .length

        [home_team_id, (games_won.fdiv(total_games_played)).round(2)] 
      end
      .to_h
  end

  def win_percentage_for_team_per_season(games_list = games)
    games_list
      .group_by(&:season)
      .map {|season, games|  [season,stat_tracker.win_percentage(games)]}
  end

  def win_percentage(games_list = games)
    (percent_home_wins(games) + percent_away_wins(games))
      .fdiv(2)
  end

 def team_id_with_lowest_number_of_goals_allowed_per_game
    home_goals_allowed
      .merge(away_goals_allowed) do 
        |team_id, home_allowed,away_allowed|
        home_allowed + away_allowed
      end
      .min_by {|team_id,goals_allowed| goals_allowed}[0]
 end


def team_id_with_highest_number_of_goals_allowed_per_game
    home_goals_allowed
      .merge(away_goals_allowed) do 
        |team_id, home_allowed,away_allowed|
        home_allowed + away_allowed
      end
      .max_by {|team_id,goals_allowed| goals_allowed}[0]
 end

  def team_id_with_highest_score_per_game_when_away
    games
      .group_by(&:away_team_id)
      .map {|away_team_id, games| [away_team_id,total_away_goals(games)]}
      .to_h
      .max_by {|away_team_id, away_goals| away_goals }[0]
  end

  def team_id_with_highest_score_per_game_when_home
    games
      .group_by(&:home_team_id)
      .map {|home_team_id, games| [home_team_id,total_home_goals(games)]}
      .to_h
      .max_by {|home_team_id, home_goals| home_goals }[0]
  end

  def team_id_with_lowest_score_per_game_when_away
    games
      .group_by(&:away_team_id)
      .map {|away_team_id, games| [away_team_id,total_away_goals(games)]}
      .to_h
      .min_by {|away_team_id, away_goals| away_goals }[0]
  end

  def team_id_with_lowest_score_per_game_when_home
    games
      .group_by(&:home_team_id)
      .map {|home_team_id, games| [home_team_id,total_home_goals(games)]}
      .to_h
      .min_by {|home_team_id, home_goals| home_goals }[0]
  end

  def team_id_with_biggest_difference_in_home_away_wins
    percent_home_wins
      .merge(percent_away_wins) do |team_id, home_win_percent,away_win_percent|
        home_win_percent - away_win_percent
      end
      .max_by {|team_id,difference| difference}[0]
  end

  def array_of_team_ids_with_better_away_records
    percent_home_wins
      .merge(percent_away_wins) do |team_id, home_win_percent,away_win_percent|
        home_win_percent - away_win_percent
      end
      .select {|team_id, difference| difference < 0  }
      .map {|team_id, difference| team_id}
  end

  private

 def home_goals_allowed 
  games
    .group_by(&:away_team_id)
    .map do |away_team_id, games|
      [away_team_id, total_home_goals(games)]
    end  
    .to_h
 end

def away_goals_allowed 
  games
    .group_by(&:home_team_id)
    .map do |home_team_id, games|
      [home_team_id, total_away_goals(games)]
    end  
    .to_h
 end

  def team_id_with_lowest_number_of_goals_allowed_per_home_game 
    games
      .group_by(&:home_team_id)
      .map do |home_team_id, games|
        [home_team_id, difference_of_goals_per_game(games)]
      end 
      .to_h
  end

  def team_id_with_lowest_number_of_goals_allowed_per_away_game 
    games
      .group_by(&:away_team_id)
      .map do |away_team_id, games|
        [away_team_id, difference_of_goals_per_game(games)] 
      end
      .to_h
  end

  def difference_of_goals_per_game(games)
    games
      .reduce(0) { |sum, game| (sum + (game.home_goals - game.away_goals).abs)}
  end

  def total_away_goals(games)
    games
      .reduce(0){|sum, game| sum + game.away_goals }
  end

  def total_home_goals(games)
    games
    .reduce(0){|sum, game| sum + game.home_goals }
  end


  def team_id_with_highest_percent_wins
    game_stats
      .group_by(&:team_id)
      .map do |team_id, stats| 
        [team_id,((total_wins(stats)).fdiv(stats.length)).round(2)]
      end
      .to_h
      .max_by {|team_id,wins| wins}[0]
  end

  def percent_home_wins(games_list = games)
    games
      .group_by(&:home_team_id)
      .map do |team_id,games| 
        [team_id,((total_home_wins(games)).fdiv(games.length)).round(2) ]
      end
      .to_h
  end

  def percent_away_wins(games_list = games)
    games
      .group_by(&:away_team_id)
      .map do |team_id,games| 
        [team_id,((total_away_wins(games)).fdiv(games.length)).round(2) ]
      end
      .to_h
  end

  def total_home_wins(games)
    games
      .select {|game| game.outcome.include?("home win")}
      .length
  end

  def total_away_wins(games)
    games
      .select {|game| game.outcome.include?("away win")}
      .length
  end

  class << self
    def highest_total_score(games)
      games
      .map(&:total_goals)
      .max
    end

    def lowest_total_score(games)
      games
        .map(&:total_goals)
        .min
    end

    def biggest_blowout(games)
      games
        .map(&:difference_goals)
        .max
    end

    def percentage_home_wins(games)
      (total_home_wins(games).to_f / games.length)
        .round(2)
    end

    def percentage_visitor_wins(games)
      (total_visitor_wins(games).to_f / games.length)
        .round(2)
    end

    def count_of_games_by_season(games)

      games
        .group_by(&:season)
        .map { |k, v| [k, v.length] }
        .to_h
    end

    def average_goals_per_game(games)
      games
        .reduce(0) {|sum, game| sum + game.total_goals }
        .fdiv(games.length)
        .round(2)

    end

    def average_goals_by_season(games)
      games
        .group_by(&:season)
        .map  do |k,v| 
          goals = v.reduce(0){|sum, game| sum + game.total_goals}

          [k, goals.fdiv(v.length)] 
        end
        .to_h

    end


    private

    def total_home_wins(games)
      games.select { |game|  game.outcome.include? "home win"}
        .length 
    end

    def total_visitor_wins(games)
      games.select { |game|  game.outcome.include? "away win"}
        .length 
    end
  end


end
