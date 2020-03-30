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
      team = stat_tracker.teams[0]

      games = stat_tracker.games

      it 'returns an array'  do
        expect(team.home_games(games)).to be_a(Array)
      end

      it 'returns an array with amount of home games for that team' do
        expect(team.home_games(games).length).to eql(3)
      end
    end
  end

  

  describe '#home_goals' do 
    context 'when called' do
      team = stat_tracker.teams[0]
      games = stat_tracker.games

      it 'returns Integer' do
        expect(team.home_goals(games)).to be_a(Integer)
      end
      it 'returns sum of home goals across seasons for that team' do
        expect(team.home_goals(games)).to eq(11)
      end
    end
  end

  describe '#away_games' do
    context 'when called with list of games' do
      team = stat_tracker.teams[0]

      games = stat_tracker.games

      it 'returns an array'  do
        expect(team.away_games(games)).to be_a(Array)
      end

      it 'returns an array with amount of away games for that team' do
        expect(team.away_games(games).length).to eql(2)
      end
    end
  end

  describe '#away_goals' do 
    context 'when called' do
      team = stat_tracker.teams[0]
      games = stat_tracker.games

      it 'returns Integer' do
        expect(team.away_goals(games)).to be_a(Integer)
      end
      it 'returns sum of home goals accros seasons for that team' do
        expect(team.away_goals(games)).to eq(5)
      end
    end
  end

  describe '#goals_allowed' do
    context 'when called' do
      team = stat_tracker.teams[0]
      games = stat_tracker.games

      it 'returns Integer' do
        expect(team.goals_allowed(games)).to be_a(Integer)
      end
      it 'returns goals allowed across seasons for that team' do
        expect(team.goals_allowed(games)).to eq(10)
      end
    end
  end

  describe '#win_percentage' do
    context 'when called' do
      team = stat_tracker.teams[0]
      game_stats = stat_tracker.game_stats
      

      it 'returns Integer' do
        my_win_stats = team.win_percentage(game_stats)

        expect(team.win_percentage(game_stats)).to be_a(Float)
      end
      it 'returns goals allowed across seasons for that team' do
        expect(team.win_percentage(game_stats)).to eq(0.80)
      end
    end
  end
end