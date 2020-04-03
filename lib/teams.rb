class Teams
  class << self
    def count_of_teams(teams)
      teams.length
    end

    def best_offense(teams)

    
      teams
        .group_by(&:team_name)
        .map do |k, v| 
          goals = v.reduce(0){|sum, team| sum + team.total_goals(games)}
          
          [k, v.length]
        end
    end

  end
end