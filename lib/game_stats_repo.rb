require 'pry'

class GameStatsRepo

  attr_reader :stat_tracker, :game_stats
  
  def initialize(stat_tracker, game_stats )
    @stat_tracker = stat_tracker
    @game_stats = game_stats
  end

  def team_id_with_highest_average_of_goals_per_game
    game_stats
      .group_by(&:team_id)
      .map {|team_id,stats| [team_id,((sum_of_goals(stats)).fdiv(stats.length)).round(2)]}
      .to_h
      .max_by { |team_id, goals| goals }[0]
  end

  def team_id_with_lowest_average_of_goals_per_game
    game_stats
    .group_by(&:team_id)
    .map {|team_id,stats| [team_id,((sum_of_goals(stats)).fdiv(stats.length)).round(2)]}
    .to_h
    .min_by {|team_id,goals| goals}[0]
  
  end

  def team_id_with_highest_percent_wins
    game_stats
      .group_by(&:team_id)
      .map{|team_id, stats| [team_id,((total_wins(stats)).fdiv(stats.length)).round(2)]}
      .to_h
      .max_by {|team_id,wins| wins}[0]
  end

  def team_id_with_lowest_percent_wins
    game_stats
      .group_by(&:team_id)
      .map{|team_id, stats| [team_id,((total_wins(stats)).fdiv(stats.length)).round(2)]}
      .to_h
      .min_by {|team_id,wins| wins}[0]
  end

  def most_goals_scored(team_id)
    game_stats
      .find_all { |game_stat|  game_stat.team_id == team_id}
      .max_by(&:goals)
      .goals
  end

  def fewest_goals_scored(team_id)
    game_stats
      .find_all { |game_stat|  game_stat.team_id == team_id}
      .min_by(&:goals)
      .goals
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
  
  def total_wins(stats)
    stats
      .select {|stat| stat.won == TRUE}
      .length
  end
end