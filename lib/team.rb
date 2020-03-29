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

  # private 
  # def home_or_away?

end 