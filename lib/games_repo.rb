class GamesRepo 

  attr_reader :games

  def initialize(stat_tracker, games)
    @stat_tracker = stat_tracker
    @games = games
  end

  def team_id_with_lowest_number_of_goals_allowed_per_game
    team_id_with_lowest_number_of_goals_allowed_per_home_game
      .merge(team_id_with_lowest_number_of_goals_allowed_per_away_game) do |team_id, home_difference,away_difference|
        home_difference + away_difference
      end
      .min_by {|team_id,difference| difference}[0]

  end

  def team_id_with_highest_number_of_goals_allowed_per_game
    team_id_with_lowest_number_of_goals_allowed_per_home_game
      .merge(team_id_with_lowest_number_of_goals_allowed_per_away_game) do |team_id, home_difference,away_difference|
        home_difference + away_difference
      end
      .max_by {|team_id,difference| difference}[0]
  end

  def team_id_with_highest_score_per_game_when_away
    games
      .group_by(&:away_team_id)
      .map {|away_team_id, games| [away_team_id,total_away_goals(games)]}
      .to_h
      .max_by {|away_team_id, away_goals| away_goals }[0]
  end

  def team_id_with_lowest_score_per_game_when_away
    games
      .group_by(&:away_team_id)
      .map {|away_team_id, games| [away_team_id,total_away_goals(games)]}
      .to_h
      .min_by {|away_team_id, away_goals| away_goals }[0]
  end

  private

  def team_id_with_lowest_number_of_goals_allowed_per_home_game 
    games
      .group_by(&:home_team_id)
      .map { |home_team_id, games| [home_team_id, difference_of_goals_per_game(games)] }
      .to_h
  end
  def team_id_with_lowest_number_of_goals_allowed_per_away_game 
    games
      .group_by(&:away_team_id)
      .map { |away_team_id, games| [away_team_id, difference_of_goals_per_game(games)] }
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