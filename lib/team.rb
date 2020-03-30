class Team
  attr_reader :team_id, :franchise_id, :short_name, :team_name, :abbreviation, :link

  def initialize(team)
    @team_id = team[:team_id]
    @franchise_id = team[:franchiseid]
    @short_name = team[:shortname]
    @team_name = team[:teamname]
    @abbreviation = team[:abbreviation]
    @link = team[:link]
  end

  def home_games(games)
    games.select { |game| game.home_team_id == team_id }
  end

  def home_goals(games)
    home_games(games).reduce(0) {|sum, game| sum + game.home_goals}
  end

  def away_games(games)
    games.select { |game| game.away_team_id == team_id }
  end

  def away_goals(games)
    away_games(games).reduce(0) {|sum, game| sum + game.away_goals}
  end

  def goals_allowed(games)
    home_goals_allowed = home_games(games).reduce(0) {|sum, game| sum + game.away_goals}

    away_goal_allowed = away_games(games).reduce(0) {|sum, game| sum + game.home_goals}

    home_goals_allowed + away_goal_allowed
  end

  def win_percentage(game_stats)

    total_games = game_stats.length / 2
    

    season_games = game_stats.select {|stat|  stat.team_id == team_id}

    team_wins = season_games.select {|stat| stat.won == "TRUE"}


    win_pct = team_wins.length.to_f / total_games

    win_pct.round(2)
  end




  # private 
  # def home_or_away?

end 