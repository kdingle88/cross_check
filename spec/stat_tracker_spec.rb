require 'rspec'
require './lib/stat_tracker'

game_path = './fixtures/game.csv'
team_path = './fixtures/team_info.csv'
game_teams_path = './fixtures/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


RSpec.describe StatTracker do
  describe '::from_csv' do
    it 'returns an instance of StatTracker.' do
      expect(StatTracker.from_csv(locations)).to be_instance_of(StatTracker)
    end
    
  end
end