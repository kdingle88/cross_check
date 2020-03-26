class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :outcome, :home_rink_side_start, :venue, :venue_link, :venue_time_zone_id, :venue_time_zone_offset, :venue_time_zone_tz

  def initialize(game)
    @game_id = game[:game_id]
    @season = game[:season]
    @type = game[:type]
    @date_time = game[:date_time]
    @away_team_id = game[:away_team_id]
    @home_team_id = game[:home_team_id]
    @away_goals = game[:away_goals]
    @home_goals = game[:home_goals]
    @outcome = game[:outcome]
    @home_rink_side_start = game[:home_rink_side_start]
    @venue = game[:venue]
    @venue_link = game[:venue_link]
    @venue_time_zone_id = game[:venue_time_zone_id]
    @venue_time_zone_offset = game[:venue_time_zone_offset]
    @venue_time_zone_tz = game[:venue_time_zone_tz]
  end
end