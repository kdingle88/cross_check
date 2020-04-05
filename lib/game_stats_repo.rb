require 'pry'

class GameStatsRepo

  attr_reader :game_stats
  
  def initialize(stat_tracker, game_stats )
    @stat_tracker = stat_tracker
    @game_stats = game_stats
  end

  def team_id_with_highest_number_of_goals_per_game
    game_stats
      .group_by(&:team_id)
      .map {|team_id,stats| [team_id,sum_of_goals(stats)]}
      .to_h
      .max_by { |team_id, goals| goals }[0]
  end

  def team_id_with_lowest_number_of_goals_per_game
    game_stats
    .group_by(&:team_id)
    .map {|team_id,stats| [team_id,sum_of_goals(stats)]}
    .to_h
    .min_by {|team_id,goals| goals}[0]
  
  end

  def team_id_with_lowest_number_of_goals_allowed_per_game
    # game_stats 
    #   .group_by(&:game_id)
    #   .map { |game_id,stats| [game_id, difference_of_goals(stats) ]  }
    #   .to_h
      #Another method that finds the games for each team, then finds the difference in goals per game, and adds them together

      # Hash[games_per_team(game_stats).keys.zip(difference_goals_per_game(game_stats).keys)]

      # {
      #   3483489938: 3
      # }

  #     game_stats
  #     .group_by(&:team_id)
  #     .map do |team_id, stat| [team_id, stat]
  #       stat
  #       .map(&:game_id)
  #     end
  #     .to_h

    # game_stats
    #   .group_by(&:team_id)
    #   .map { |team_id,stats| [team_id, the_difference(stats)] }

      game_stats
      .group_by(&:game_id)
      .map { |game_id,stats| [game_id, the_difference(stats)] }
      .to_h

      # Hash[games_per_team(game_stats).keys.zip(the_games(game_stats).keys)]

  end
  
  private

  def sum_of_goals(stats)
    stats
      .reduce(0){|sum,stat| sum + stat.goals}
  end

  def the_games(stats)
    stats
      .group_by(&:game_id)
      .map { |game_id,stats| [game_id, the_difference(stats)] }
      .to_h
  end

  def the_difference(stats)
    stats
      .reduce(0) {|diff, stat| (diff - stat.goals).abs }
  end

  def games_per_team(game_stats)
    game_stats
      .group_by(&:team_id)
      .map {|team_id, stat| [team_id, get_game_id(stat)]}
      .to_h
  end

  def get_game_id(stat)
    stat
      .map(&:game_id)
  end

  

  def difference_goals_per_game(game_stats)
    game_stats 
      .group_by(&:game_id)
      .map { |game_id,stats| [game_id, difference_of_goals(stats) ]  }
      .to_h
  end

  

  def difference_of_goals(stats)
    stats
      .reduce(0) { |diff, stat| (diff - stat.goals).abs }
  end 
  
end