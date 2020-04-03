require 'rspec'
require './lib/team'
require './lib/game'
require 'pry'




game_uno = Game.new({
  game_id:2012030221,
  season:20122013,
  type:"P",
  date_time:2013-05-16,
  away_team_id: "3",
  home_team_id:"6",
  away_goals:2,
  home_goals:3,
  outcome:"home win OT",
  home_rink_side_starts:"left",
  venue:"TD Garden",
  venue_link:"/api/v1/venues/null",
  venue_time_zone_id:"America/New_York",
  venue_time_zone_offset:-4,
  venue_time_zone_tz:"EDT"
})

game_dos = Game.new({
  game_id:2016030132,
  season:20162017,
  type:"P",
  date_time:2017-04-15,
  away_team_id:"6",
  home_team_id:"15",
  away_goals:4,
  home_goals:3,
  outcome:"away win OT",
  home_rink_side_starts:"right",
  venue:"Verizon Center",
  venue_link:"/api/v1/venues/null",
  venue_time_zone_id:"America/New_York",
  venue_time_zone_offset:-4,
  venue_time_zone_tz:"EDT"
})

game_tres = Game.new({
  game_id:2017030121,
  season:20172018,
  type:"P",
  date_time:2018-04-12,
  away_team_id:"10",
  home_team_id:"6",
  away_goals:1,
  home_goals:5,
  outcome:"home win REG",
  home_rink_side_starts:"left",
  venue:"Verizon Center",
  venue_link:"/api/v1/venues/null",
  venue_time_zone_id:"America/New_York",
  venue_time_zone_offset:-4,
  venue_time_zone_tz:"EDT"
})

game_quatro = Game.new({
  game_id:2013020902,
  season:20132014,
  type:"R",
  date_time:2014-03-01,
  away_team_id:"15",
  home_team_id:"6",
  away_goals:4,
  home_goals:2,
  outcome:"away win REG",
  home_rink_side_starts:"left",
  venue:"TD Garden",
  venue_link:"/api/v1/venues/null",
  venue_time_zone_id:"America/New_York",
  venue_time_zone_offset:-4,
  venue_time_zone_tz:"EDT"
})
game_cinco = Game.new({
  game_id:2012020592,
  season:20122013,
  type:"R",
  date_time:2013-04-10,
  away_team_id:"6",
  home_team_id:"3",
  away_goals:2,
  home_goals:3,
  outcome:"home win SO",
  home_rink_side_starts:"right",
  venue:"Madison Square Garden",
  venue_link:"/api/v1/venues/null",
  venue_time_zone_id:"America/New_York",
  venue_time_zone_offset:-4,
  venue_time_zone_tz:"EDT"
})

RSpec.describe Team do
  subject { 
    Team.new({
      team_id:  "6",
      franchiseid: "6",
      shortname: "Boston",
      teamname: "Bruins",
      abbreviation: "BOS",
      link: "/api/v1/teams/6"
  })
}
#   describe '#home_games' do
    
#     context 'when called with list of games' do
#       team = stat_tracker.teams[0]

#       games = stat_tracker.games

#       it 'returns an array'  do
#         expect(team.home_games(games)).to be_a(Array)
#       end

#       it 'returns an array with amount of home games for that team' do
#         expect(team.home_games(games).length).to eql(3)
#       end
#     end
#   end

  

#   describe '#home_goals' do 
#     context 'when called' do
#       team = stat_tracker.teams[0]
#       games = stat_tracker.games

#       it 'returns Integer' do
#         expect(team.home_goals(games)).to be_a(Integer)
#       end
#       it 'returns sum of home goals across seasons for that team' do
#         expect(team.home_goals(games)).to eq(11)
#       end
#     end
#   end

#   describe '#away_games' do
#     context 'when called with list of games' do
#       team = stat_tracker.teams[0]

#       games = stat_tracker.games

#       it 'returns an array'  do
#         expect(team.away_games(games)).to be_a(Array)
#       end

#       it 'returns an array with amount of away games for that team' do
#         expect(team.away_games(games).length).to eql(2)
#       end
#     end
#   end

#   describe '#away_goals' do 
#     context 'when called' do
#       team = stat_tracker.teams[0]
#       games = stat_tracker.games

#       it 'returns Integer' do
#         expect(team.away_goals(games)).to be_a(Integer)
#       end
#       it 'returns sum of home goals accros seasons for that team' do
#         expect(team.away_goals(games)).to eq(5)
#       end
#     end
#   end

#   describe '#goals_allowed' do
#     context 'when called' do
#       team = stat_tracker.teams[0]
#       games = stat_tracker.games

#       it 'returns Integer' do
#         expect(team.goals_allowed(games)).to be_a(Integer)
#       end
#       it 'returns goals allowed across seasons for that team' do
#         expect(team.goals_allowed(games)).to eq(10)
#       end
#     end
#   end

#   describe '#win_percentage' do
#     context 'when called' do
#       team = stat_tracker.teams[0]
#       game_stats = stat_tracker.game_stats
      

#       it 'returns Integer' do
#         my_win_stats = team.win_percentage(game_stats)

#         expect(team.win_percentage(game_stats)).to be_a(Float)
#       end
#       it 'returns goals allowed across seasons for that team' do
#         expect(team.win_percentage(game_stats)).to eq(0.80)
#       end
#     end
#   end

#   describe '#home_win_percentage' do
#     context 'when called' do
#       team = stat_tracker.teams[0]

#       game_stats = stat_tracker.game_stats

#       home_win_stats = team.home_win_percentage(game_stats)
      

#       it 'returns Integer' do
#         expect(home_win_stats).to be_a(Float)
#       end
#       it 'returns home win percentage for all seasons' do
#         expect(home_win_stats).to eq(1.00)
#       end
#     end
#   end

#   describe '#away_win_percentage' do
#     context 'when called' do
#       team = stat_tracker.teams[0]

#       game_stats = stat_tracker.game_stats

#       away_win_stats = team.away_win_percentage(game_stats)
      

#       it 'returns Integer' do
#         expect(away_win_stats).to be_a(Float)
#       end
#       it 'returns away win percentage for all seasons' do
#         expect(away_win_stats).to eq(0.50)
#       end
#     end
#   end

# describe '#home_team_wins' do
#   context 'when called' do
#     team = stat_tracker.teams[0]

#     game_stats = stat_tracker.game_stats

#     home_wins = team.home_team_wins(game_stats)
    

#     it 'returns Integer' do
#       expect(home_wins).to be_a(Array)
#     end
#     it 'returns away win percentage for all seasons' do
#       expect(home_wins.length).to eq(3)
#     end
#   end
# end

# describe '#away_team_wins' do
#   context 'when called' do
#     team = stat_tracker.teams[0]

#     game_stats = stat_tracker.game_stats

#     away_wins = team.away_team_wins(game_stats)
    

#     it 'returns Integer' do
#       expect(away_wins).to be_a(Array)
#     end
#     it 'returns away win percentage for all seasons' do
#       expect(away_wins.length).to eq(1)
#     end
#   end
# end

  describe '#total_goals' do
    context 'when given games' do
      three_games = [game_uno, game_tres, game_cinco]
      
      five_games = [game_uno,game_dos,game_tres, game_quatro,game_cinco]

      it 'returns the sum of away goals and home goals' do
        expect(subject.total_goals(three_games)).to be(10)
      end

      it 'returns the sum of away goals and home goals test 2' do
        expect(subject.total_goals(five_games)).to be(16)
      end
    end
  end


  # describe '#wins_per_season' do
  #   skip
  #   context 'when called' do
  #   end
  # end
end