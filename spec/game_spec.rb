require 'rspec'
require './lib/game'

game_data = {
  game_id: "2012030221", 
  season: "20122013", 
  type: "P", 
  date_time: 2013-05-16, 
  away_team_id: "3", 
  home_team_id: "6", 
  away_goals: 2, 
  home_goals: 3, 
  outcome: "home win OT", 
  home_rink_side_start: "left", 
  venue: "TD Garden", 
  venue_link: "/api/v1/venues/null", 
  venue_time_zone_id: "America/New_York", 
  venue_time_zone_offset: -4, 
  venue_time_zone_tz: "EDT"

}

RSpec.describe Game do 
  subject { Game.new(game_data)}

  describe '#total_goals' do
    context 'when called' do
      it 'returns an Integer' do
        expect(subject.total_goals).to be_a(Integer)
      end
      it 'returns the sum of away goals and home goals' do
        expect(subject.total_goals).to be(5)
      end
    end
  end
  
  describe '#difference_goals' do
    context 'when called' do
      it 'returns an Integer' do
        expect(subject.difference_goals).to be_a(Integer)
      end
      it 'returns the difference of away goals and home goals' do
        expect(subject.difference_goals).to be(1)
      end

    end
  end
end