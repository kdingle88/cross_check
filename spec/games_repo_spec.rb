require 'rspec'
require './lib/games_repo'
require './lib/game'
# require './lib/stat_tracker'

# game_path = './spec/fixtures/game.csv'
# team_path = './spec/fixtures/team_info.csv'
# game_teams_path = './spec/fixtures/game_teams_stats.csv'

# locations = {
#   games: game_path,
#   teams: team_path,
#   game_teams: game_teams_path
# }

def default_game_params
  {
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
  }
end

def build_game(override_params = {})
Game.new(default_game_params.merge(override_params))
end

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
  away_team_id:"10",
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
  away_team_id:"10",
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



RSpec.describe GamesRepo do
  describe '#highest_total_score' do
    context 'when given games' do
      three_games = [game_uno, game_tres, game_cinco]
      
      five_games = [game_uno,game_dos,game_tres, game_quatro,game_cinco]
      
      it 'returns highest sum of the winning and losing teams scores' do
        five_games_high_score = GamesRepo.highest_total_score(five_games)

        expect(five_games_high_score).to eql(7)
      end
      it 'returns highest sum of the winning and losing teams scores test 2' do
        three_games_high_score = GamesRepo.highest_total_score(three_games)

        expect(three_games_high_score).to eql(6)
      end
    end
  end
  describe '#lowest_total_score' do
    context 'when given games' do
      three_games = [game_dos, game_tres, game_quatro]

      five_games = [game_uno,game_dos,game_tres, game_quatro,game_cinco]
      
      it 'returns lowest sum of the winning and losing teams scores' do
        five_games_low_score = GamesRepo.lowest_total_score(five_games)

        expect(five_games_low_score).to eql(5)
      end

      it 'returns lowest sum of the winning and losing teams scores test 2' do
        three_games_low_score = GamesRepo.lowest_total_score(three_games)

        expect(three_games_low_score).to eql(6)
      end
    end
  end

  describe '#biggest_blowout' do
    context 'when given games' do
      three_games = [game_dos, game_tres, game_quatro]

      four_games = [game_uno,game_dos, game_quatro,game_cinco]

      it 'returns highest difference between winner and loser' do
        three_games_big_blowout = GamesRepo.biggest_blowout(three_games)

        expect(three_games_big_blowout).to eql(4)
      end

      it 'returns highest difference between winner and loser test 2' do
        four_games_big_blowout = GamesRepo.biggest_blowout(four_games)

        expect(four_games_big_blowout).to eql(2)
      end
    end
  end

  describe '#percentage_home_wins' do
    context 'when given games' do
      three_games = [game_uno, game_dos, game_cinco]

      four_games = [game_uno,game_dos, game_quatro,game_cinco]

      it 'returns percentage of games that a home team has won (rounded to the nearest 100th)' do
        three_games_pct_home_wins = GamesRepo.percentage_home_wins(three_games)

        expect(three_games_pct_home_wins).to eql(0.67)
      end

      it 'returns percentage of games that a home team has won (rounded to the nearest 100th) test 2' do
        four_games_pct_home_wins = GamesRepo.percentage_home_wins(four_games)

        expect(four_games_pct_home_wins).to eql(0.50)
      end
    end
  end

  describe '#percentage_visitor_wins' do
    context 'when given games' do
      three_games = [game_uno, game_dos, game_cinco]

      four_games = [game_uno,game_dos, game_quatro,game_cinco]

      it 'returns percentage of games that a visitor team has won (rounded to the nearest 100th)' do
        three_games_pct_visitor_wins = GamesRepo.percentage_visitor_wins(three_games)

        expect(three_games_pct_visitor_wins).to eql(0.33)
      end

      it 'returns percentage of games that a visitor team has won (rounded to the nearest 100th) test 2' do
        four_games_pct_visitor_wins = GamesRepo.percentage_visitor_wins(four_games)

        expect(four_games_pct_visitor_wins).to eql(0.50)
      end
    end
  end

  describe '#count_of_games_by_season' do
    context 'when given games' do
      two_games = [game_uno, game_dos]

      three_games = [game_uno, game_quatro,game_cinco]

      it 'returns A hash with season names as keys and counts of games as values' do
        two_game_hash = {
          20122013 => 1,
          20162017 => 1
        }

        two_games_season = GamesRepo.count_of_games_by_season(two_games)
        
        expect(two_games_season).to include(two_game_hash)
      end

      it 'returns A hash with season names as keys and counts of games as values test 2' do
        three_game_hash = {
          20122013 => 2,
          20132014 => 1,
        }

        three_games_season = GamesRepo.count_of_games_by_season(three_games)
        
        expect(three_games_season).to include(three_game_hash)
      end
    end
  end

  describe '#average_goals_per_game' do
    context 'when givin games' do
      three_games = [game_dos, game_tres, game_quatro]

      four_games = [game_uno,game_dos, game_quatro,game_cinco]

      it 'returns average number of goals scored in a game across all seasons, home and away (rounded to the nearest 100th)' do
        three_games_avg_goals = GamesRepo.average_goals_per_game(three_games)

        expect(three_games_avg_goals).to eql(6.33)
      end

      it 'returns average number of goals scored in a game across all seasons, home and away (rounded to the nearest 100th) test 2' do
        four_games_avg_goals = GamesRepo.average_goals_per_game(four_games)

        expect(four_games_avg_goals).to eql(5.75)
      end
    end
  end


  describe '#average_goals_by_season' do
    context 'when given games' do
      two_games = [game_uno, game_dos]

      three_games = [game_uno, game_quatro,game_cinco]

      it 'returns A hash with season names as keys and float representing the average number of goals in a game for that season as a key' do
        two_game_hash = {
          20122013 => 5.00,
          20162017 => 7
        }

        two_games_season = GamesRepo.average_goals_by_season(two_games)
        
        expect(two_games_season).to include(two_game_hash)
      end

      it 'returns A hash with season names as keys and counts of games as values test 2' do
        three_game_hash = {
          20122013 => 5.00,
          20132014 => 6,
        }

        three_games_season = GamesRepo.average_goals_by_season(three_games)
        
        expect(three_games_season).to include(three_game_hash)
      end
    end
  end
  describe '#team_id_with_lowest_number_of_goals_allowed_per_game' do
    it 'returns id of team with the lowest number of goals allowed per game across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_lowest_number_of_goals_allowed_per_game).to eql("15")
    end
  end
  describe '#team_id_with_highest_number_of_goals_allowed_per_game' do
    it 'returns id of team with the highest number of goals allowed per game across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_number_of_goals_allowed_per_game).to eql("3")
    end
  end

  describe '#team_id_with_highest_score_per_game_when_away' do
    it 'returns id of team with the highest number of away goals across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_score_per_game_when_away).to eql("3")
    end
  end

  describe '#team_id_with_highest_score_per_game_when_home' do
    it 'returns id of team with the highest number of home goals across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_score_per_game_when_home).to eql("6")
    end
  end

  describe '#team_id_with_lowest_score_per_game_when_away' do
    it 'returns id of team with the lowest number of away goals across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]

      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_lowest_score_per_game_when_away).to eql("15")
    end
  end

  describe '#team_id_with_lowest_score_per_game_when_home' do
    it 'returns id of team with the lowest number of home goals across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6",away_goals:5,home_goals:8}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",away_goals:2,home_goals:3}),
        build_game({ game_id: 2012030223,away_team_id: "3",home_team_id:"15",away_goals:1,home_goals:4}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6",away_goals:3,home_goals:5}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_lowest_score_per_game_when_home).to eql("3")
    end
  end

  describe '#team_id_with_biggest_difference_in_home_away_wins' do
    it 'returns id of team with biggest difference in home and away wins across all seasons' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"6", outcome:"home win OT"}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",outcome:"home win REG"}),
        build_game({ game_id: 2012030223, away_team_id: "3", home_team_id:"15", outcome: "away win REG"}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6", outcome:"home win REG"}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",outcome:"away win OT"}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",outcome:"away win REG"})
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_biggest_difference_in_home_away_wins).to eql("6")
    end
  end

  describe '#array_of_team_ids_with_better_away_records' do
    it 'returns array of team ids with better away records' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"15", outcome:"home win OT"}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"3",outcome:"away win REG"}),
        build_game({ game_id: 2012030223, away_team_id: "6", home_team_id:"15", outcome: "away win REG"}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6", outcome:"away win REG"}),
        build_game({ game_id: 2012030225,away_team_id: "6",home_team_id:"14",outcome:"away win OT"}),
        build_game({ game_id: 2012030226,away_team_id: "14",home_team_id:"3",outcome:"away win REG"})
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.array_of_team_ids_with_better_away_records).to contain_exactly("15","6", "14")
    end
  end
  
  describe '#team_id_lowest_win_percentage_against_the_given_team' do
    it 'returns team id of lowest win percentage against givin team' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"15", outcome:"home win OT"}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"15",outcome:"away win REG"}),
        build_game({ game_id: 2012030223, away_team_id: "6", home_team_id:"15", outcome: "away win REG"}),
        build_game({ game_id: 2012030224,away_team_id: "15",home_team_id:"6", outcome:"away win REG"}),
        build_game({ game_id: 2012030225,away_team_id: "3",home_team_id:"15",outcome:"away win OT"}),
        build_game({ game_id: 2012030226,away_team_id: "3",home_team_id:"15",outcome:"away win REG"})
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_lowest_win_percentage_against_the_given_team("3")).to eql("15")
    end
  end

  describe '#team_id_highest_win_percentage_against_the_given_team' do
    it 'returns team id of highest win percentage against givin team' do
      
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"15", outcome:"home win OT"}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"15",outcome:"away win REG"}),
        build_game({ game_id: 2012030223, away_team_id: "6", home_team_id:"15", outcome: "away win REG"}),
        build_game({ game_id: 2012030224,away_team_id: "3",home_team_id:"6", outcome:"away win REG"}),
        build_game({ game_id: 2012030225,away_team_id: "3",home_team_id:"15",outcome:"away win OT"}),
        build_game({ game_id: 2012030226,away_team_id: "3",home_team_id:"15",outcome:"away win REG"})
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_highest_win_percentage_against_the_given_team("3")).to eql("6")
    end
  end

  describe '#biggest_team_blowout' do
    it 'returns biggest difference between team goals and opponent goals for a win for the given team' do   
      games = [
        build_game({ game_id: 2012030221,away_team_id: "3",home_team_id:"15", outcome:"home win OT"}),
        build_game({ game_id: 2012030222,away_team_id: "6",home_team_id:"15",outcome:"away win REG"}),
        build_game({ game_id: 2012030223, away_team_id: "6", home_team_id:"15", outcome: "away win REG"}),
        build_game({ game_id: 2012030224,away_team_id: "3",home_team_id:"6", outcome:"away win REG"}),
        build_game({ game_id: 2012030225,away_team_id: "3",home_team_id:"15",outcome:"away win OT"}),
        build_game({ game_id: 2012030226,away_team_id: "3",home_team_id:"15",outcome:"away win REG"})
      ]

      
      games_repo = GamesRepo.new(stat_tracker, games)

      expect(games_repo.biggest_team_blowout("3")).to eql("6")
    end
  end



end
