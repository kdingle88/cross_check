require 'rspec'
require './lib/game_stat'
require './lib/stat_tracker'
require 'pry'

game_path = './spec/fixtures/game.csv'
team_path = './spec/fixtures/team_info.csv'
game_teams_path = './spec/fixtures/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

# game_stat_data = {
#   game_id: "2012030221", 
#   team_id: "6", 
#   hoa: "home", 
#   won: TRUE, 
#   settled_in: "OT", 
#   head_coach: "Claude Julien", 
#   goals: 3, 
#   shots: 48, 
#   hits: 51, 
#   pim: 6, 
#   powerplayopportunities: 4, 
#   powerplaygoals: 1, 
#   faceoffwinpercentage: 55.2, 
#   giveaways: 4, 
#   takeaways: 5
# }

RSpec.describe GameStat do
  subject { GameStat.new(game_stat_data)}

end