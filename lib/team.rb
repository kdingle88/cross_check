class Team
  attr_reader :team_id, :franchise_id, :short_name, :team_name, :abbreviation, :link

  def initialize(team)
    @team_id = team[:team_id]
    @franchise_id = team[:franchiseId]
    @short_name = team[:shortName]
    @team_name = team[:teamName]
    @abbreviation = team[:abbreviation]
    @link = team[:link]
  end
end 