require 'pry'

class Games
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