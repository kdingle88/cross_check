class Game_Stats 

  class << self
    def best_offense(game_stats)
      game_stats
      .group_by(&:team_id)
      .map  do |k,v| 
        goals = v.reduce(0){|sum, stat| sum + stat.goals}

        [k, goals.fdiv(v.length)] 
      end
      .to_h
    end
  end
end