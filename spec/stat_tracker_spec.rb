require 'rspec'
require './lib/stat_tracker'

game_path = './spec/fixtures/game.csv'
team_path = './spec/fixtures/team_info.csv'
game_teams_path = './spec/fixtures/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


RSpec.describe StatTracker do
  subject {StatTracker.from_csv(locations)}

  describe '::from_csv' do
    it 'returns an instance of StatTracker.' do
      expect(subject).to be_instance_of(StatTracker)
    end
  end

  describe '#highest_total_score'do
    context 'when called' do
      it 'returns integer value' do
        expect(subject.highest_total_score).to be_a(Integer)
      end
      it 'returns highest sum of the winning and losing teams scores' do
        expect(subject.highest_total_score).to be(7)
      end
    end
  end

  describe '#lowest_total_score' do
    context 'when called' do
      it 'returns integer value' do
        expect(subject.lowest_total_score).to be_a(Integer)
      end
      it 'returns lowest sum of the winning and losing teams scores' do
        expect(subject.lowest_total_score).to be(1)
      end
    end
  end

  describe '#biggest_blowout' do
    context 'when called' do
      it 'returns Integer value' do
        expect(subject.biggest_blowout).to be_a(Integer)
      end
      it 'returns highest difference between winner and loser' do
        expect(subject.biggest_blowout).to be(5)
      end
    end
  end
  describe '#percentage_home_wins' do
    context 'when called' do
      it 'returns Float value' do
        expect(subject.percentage_home_wins).to be_a(Float)
      end
      it 'returns percentage of games that a home team has won' do
        expect(subject.percentage_home_wins).to eql(0.70)
      end
    end
  end
  describe '#percentage_visitor_wins' do
    context 'when called' do
      it 'returns Float value' do
        expect(subject.percentage_visitor_wins).to be_a(Float)
      end
      it 'returns percentage of games that a visitor team has won' do
        expect(subject.percentage_visitor_wins).to eql(0.30)
      end
    end
  end

  describe '#count_of_games_by_season' do
    context 'when called' do
      it 'returns a Hash' do
        expect(subject.count_of_games_by_season).to be_a(Hash)
      end

      it 'returns a hash with season names as keys and counts of games as values' do
        expect(subject.count_of_games_by_season).to include({20122013 => 10})
      end
    end
  end

  describe '#average_goals_per_game' do
    context 'when called' do
      it 'returns a Float value' do
        expect(subject.average_goals_per_game).to be_a(Float)
      end

      it 'returns average number of goals scored in a game across all seasons including both home and away goals' do
        expect(subject.average_goals_per_game).to eq(4.50)
      end
    end
  end
end