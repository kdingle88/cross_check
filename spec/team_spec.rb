require 'rspec'
require './lib/team'
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

RSpec.describe Team do
  describe '#home_games' do
    context 'when called with list of games' do
      team = stat_tracker.teams[6]

      games = stat_tracker.games

      it 'returns an array'  do
        expect(team.home_games(games)).to be_a(Array)
      end

      it 'returns an array with amount of home games for that team' do
        expect(team.home_games(games).length).to eql(2)
      end
    end
  end

  

  describe '#home_goals' do 
    context 'when called' do
      team = stat_tracker.teams[6]
      games = stat_tracker.games

      it 'returns Integer' do
        expect(team.home_goals(games)).to be_a(Integer)
      end
      it 'returns sum of home goals accros seasons for that team' do
        expect(team.home_goals(games)).to eq(1)
      end
    end
  end

  describe '#away_games' do
    context 'when called with list of games' do
      team = stat_tracker.teams[4]

      games = stat_tracker.games

      it 'returns an array'  do
        expect(team.away_games(games)).to be_a(Array)
      end

      it 'returns an array with amount of away games for that team' do
        expect(team.away_games(games).length).to eql(4)
      end
    end
  end

  describe '#away_goals' do 
    context 'when called' do
      team = stat_tracker.teams[4]
      games = stat_tracker.games

      it 'returns Integer' do
        expect(team.away_goals(games)).to be_a(Integer)
      end
      it 'returns sum of home goals accros seasons for that team' do
        expect(team.away_goals(games)).to eq(14)
      end
    end
  end

  describe '#goals_scored_on_me' do
  end
end