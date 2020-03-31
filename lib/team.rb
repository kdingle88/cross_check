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

  def home_games(games_or_stats)

    if (games_or_stats[0].respond_to? :outcome)
      games_or_stats.select { |game| game.home_team_id == team_id }
    else
      games_or_stats.select {|stat|  stat.team_id == team_id && stat.home_or_away == "home"}
    end

  end

  def home_goals(games)
    home_games(games).reduce(0) {|sum, game| sum + game.home_goals}
  end

  def away_games(games_or_stats)

    if(games_or_stats[0].respond_to? :outcome)
      games_or_stats.select { |game| game.away_team_id == team_id }
    else
      games_or_stats.select {|stat|  stat.team_id == team_id && stat.home_or_away == "away"}
    end
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

    season_games = home_games(game_stats) + away_games(game_stats)

    team_wins = season_games.select {|stat| stat.won == "TRUE"}


    win_pct = team_wins.length.to_f / total_games(game_stats)

    win_pct.round(2)
  end

  def home_win_percentage(game_stats)
    home_win_pct = home_team_wins(game_stats).length.to_f / home_games(game_stats).length

    home_win_pct.round(2)
  end

  def away_win_percentage(game_stats)
    away_win_pct = away_team_wins(game_stats).length.to_f / away_games(game_stats).length

    away_win_pct.round(2)
  end

  def home_team_wins(game_stats)
    home_games(game_stats).select {|stat| stat.won == "TRUE"}
  end

  def away_team_wins(game_stats)
    away_games(game_stats).select {|stat| stat.won == "TRUE"}
  end

  # def wins_per_season
  #   #calcualte wins for each season..game stats should have an hash that returns season?
  # end

  



  private 
  def total_games(games_or_stats)
    home_games(games_or_stats).length + away_games(games_or_stats).length
  end

  def total_wins(games_or_stats)
    home_games(games_or_stats).length + away_games(games_or_stats).length
  end

end 