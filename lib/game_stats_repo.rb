class GameStatsRepo

  
  def initialize(stat_tracker, game_stats )
    @stat_tracker = stat_tracker
    @game_stats = game_stats
  end

  def highest_number_of_goals_per_game
    game_stats
      .group_by(&:team_id)
      .map {|team_id,stats| [team_id,aggregate(stats)]}
      .max_by { |k,v| v}
      #returns something -- unit test
  end
  
  private
  def aggregate(stats)
    stats
      .reduce(0){|sum,stat| sum + stat.goals}
  end
  
end