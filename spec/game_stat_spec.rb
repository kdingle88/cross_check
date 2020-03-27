require 'rspec'
require './lib/game_stat'

game_stat_data = {
  game_id: "2012030221", 
  team_id: "6", 
  hoa: "home", 
  won: TRUE, 
  settled_in: "OT", 
  head_coach: "Claude Julien", 
  goals: 3, 
  shots: 48, 
  hits: 51, 
  pim: 6, 
  powerplayopportunities: 4, 
  powerplaygoals: 1, 
  faceoffwinpercentage: 55.2, 
  giveaways: 4, 
  takeaways: 5
}

RSpec.describe Game_Stat do
  subject { Game_Stat.new(game_stat_data)}
end