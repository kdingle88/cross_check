require 'rspec'
require './lib/games_repo'
require './lib/game'

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
    games = [
      build_game({
         away_goals:1,
         home_goals:0
       }),
       build_game({
         away_goals:3,
         home_goals:1
       })
    ]
    
    it 'returns highest sum of the winning and losing teams scores' do
      high_score = GamesRepo.highest_total_score(games)

      expect(high_score).to eql(4)
    end
  end
  
  describe '#lowest_total_score' do
    games = [
      build_game({
        away_goals:1,
        home_goals:0
      }),
      build_game({
        away_goals:3,
        home_goals:1
      })
    ]

    it 'returns lowest sum of the winning and losing teams scores' do
      low_score = GamesRepo.lowest_total_score(games)

      expect(low_score).to eql(1)
    end
  end

  describe '#biggest_blowout' do
    games = [
      build_game({
         away_goals:3,
         home_goals:0
       }),
       build_game({
         away_goals:1,
         home_goals:6
       })
    ]

    it 'returns highest difference between winner and loser' do
      blowout = GamesRepo.biggest_blowout(games)

        expect(blowout).to eql(5)
    end
  end

  describe '#percentage_home_wins' do
    games = [
      build_game({
         outcome:"home win REG"
       }),
       build_game({
         outcome:"away win REG"
       }),
       build_game({
         outcome:"away win REG"
       })
    ]

    it 'returns percentage of games that a home team has won' do
      pct_home_wins = GamesRepo.percentage_home_wins(games)

      expect(pct_home_wins).to eql(0.33)
    end
  end

  describe '#percentage_visitor_wins' do
    games = [
      build_game({
         outcome:"home win OT"
       }),
       build_game({
         outcome:"away win REG"
       }),
       build_game({
         outcome:"away win REG"
       })
    ]

    it 'returns percentage of games that a visitor team has won' do
      pct_visitor_wins = GamesRepo
        .percentage_visitor_wins(games)

      expect(pct_visitor_wins).to eql(0.67)
    end
  end

  describe '#count_of_games_by_season' do
    games = [
      build_game({
         season:1
       }),
       build_game({
         season:2
       }),
       build_game({
         season:2 
       })
    ]

    it 'returns hash with season names as keys and game count as values' do
      result_hash = {
        1 => 1,
        2 => 2
      }

      season = GamesRepo.count_of_games_by_season(games)
        
      expect(season).to include(result_hash)
    end
  end

  describe '#average_goals_per_game' do
    games = [
      build_game({
         away_goals:4,
         home_goals:2
       }),
       build_game({
         away_goals:1,
         home_goals:2
       })
    ]

      it 'returns average number of goals scored in a game  home and away' do 
        avg_goals = GamesRepo.average_goals_per_game(games)

        expect(avg_goals).to eql(4.5)
      end
  end


  describe '#average_goals_by_season' do
    games = [
      build_game({
         season:1,
         away_goals:1,
         home_goals:0
       }),
       build_game({
         season:2,
         away_goals:0,
         home_goals:1
       }),
      build_game({
         season:1,
         away_goals:1,
         home_goals:2
       }),
       build_game({
         season:2,
         away_goals:3,
         home_goals:1
       })
    ]

    it 'returns hash of average goals by season' do 
      result_hash = {
        1 => 2.0,
        2 => 2.5
      }

      season = GamesRepo.average_goals_by_season(games)
        
      expect(season).to include(result_hash)
    end
  end

  describe '#team_id_with_lowest_number_of_goals_allowed_per_game' do

    team_one = "1" 

    team_two = "2"

    games = [
      build_game({ 
        home_team_id:team_one,
        away_goals:1,
      }),

      build_game({ 
        home_team_id:team_two,
        away_goals:2,
      })
    ]

    it 'returns team id  with the lowest number of goals allowed per game' do

      stat_tracker = double()

       games_repo = GamesRepo.new(stat_tracker, games)

       expect(games_repo.team_id_with_lowest_number_of_goals_allowed_per_game)
         .to eql(team_one)
    end
  end

  describe '#team_id_with_highest_number_of_goals_allowed_per_game' do
    it 'returns team id  with the highest number of goals allowed per game' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6",
          away_goals:5,home_goals:8
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          away_goals:2,
          home_goals:3
        }),
        build_game({ 
          game_id: 2012030223,
          away_team_id: "3",
          home_team_id:"15",
          away_goals:1,
          home_goals:4
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6",
          away_goals:3,
          home_goals:5
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          away_goals:2,
          home_goals:6
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          away_goals:5,
          home_goals:1
        })
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_number_of_goals_allowed_per_game)
        .to eql("3")
    end
  end

  describe '#team_id_with_highest_score_per_game_when_away' do
    it 'returns id of team with the highest number of away goals' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6",
          away_goals:5,
          home_goals:8}),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          away_goals:2,
          home_goals:3
          }),
        build_game({ 
          game_id: 2012030223,
          away_team_id: "3",
          home_team_id:"15",
          away_goals:1,
          home_goals:4
          }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6",
          away_goals:3,
          home_goals:5
          }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          away_goals:2,
          home_goals:6
          }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          away_goals:5,
          home_goals:1
          })
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_score_per_game_when_away)
        .to eql("3")
    end
  end

  describe '#team_id_with_highest_score_per_game_when_home' do
    it 'returns id of team with the highest number of home goals' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6",
          away_goals:5,
          home_goals:8
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          away_goals:2,
          home_goals:3
        }),
        build_game({ 
          game_id: 2012030223,
          away_team_id: "3",
          home_team_id:"15",
          away_goals:1,
          home_goals:4
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6",
          away_goals:3,home_goals:5
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          away_goals:2,
          home_goals:6
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          away_goals:5,
          home_goals:1
        })
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_highest_score_per_game_when_home)
        .to eql("6")
    end
  end

  describe '#team_id_with_lowest_score_per_game_when_away' do
    it 'returns id of team with the lowest number of away goals' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6",
          away_goals:5,
          home_goals:8
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          away_goals:2,
          home_goals:3
        }),
        build_game({ 
          game_id: 2012030223,
          away_team_id: "3",
          home_team_id:"15",
          away_goals:1,
          home_goals:4
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6",
          away_goals:3,
          home_goals:5
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",away_goals:2,home_goals:6}),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",home_team_id:"3",away_goals:5,home_goals:1})
      ]

      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_lowest_score_per_game_when_away)
        .to eql("15")
    end
  end

  describe '#team_id_with_lowest_score_per_game_when_home' do
    it 'returns id of team with the lowest number of home goals' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6",
          away_goals:5,
          home_goals:8
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          away_goals:2,
          home_goals:3
        }),
        build_game({ 
          game_id: 2012030223,
          away_team_id: "3",
          home_team_id:"15",
          away_goals:1,
          home_goals:4
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6",
          away_goals:3,
          home_goals:5
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          away_goals:2,
          home_goals:6
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          away_goals:5,
          home_goals:1
        })
      ]


      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_lowest_score_per_game_when_home)
        .to eql("3")
    end
  end

  describe '#team_id_with_biggest_difference_in_home_away_wins' do
    it 'returns id of team with biggest difference in home and away wins' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"6", 
          outcome:"home win OT"
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          outcome:"home win REG"
        }),
        build_game({ 
          game_id: 2012030223, 
          away_team_id: "3", 
          home_team_id:"15", 
          outcome: "away win REG"
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6", 
          outcome:"home win REG"
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          outcome:"away win OT"
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          outcome:"away win REG"
        })
      ]

      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_with_biggest_difference_in_home_away_wins)
        .to eql("6")
    end
  end

  describe '#array_of_team_ids_with_better_away_records' do
    it 'returns array of team ids with better away records' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"15", 
          outcome:"home win OT"
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"3",
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030223, 
          away_team_id: "6", 
          home_team_id:"15", 
          outcome: "away win REG"
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6", 
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "6",
          home_team_id:"14",
          outcome:"away win OT"
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "14",
          home_team_id:"3",
          outcome:"away win REG"
        })
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.array_of_team_ids_with_better_away_records)
        .to contain_exactly("15","6", "14")
    end
  end
  
  describe '#team_id_lowest_win_percentage_against_the_given_team' do
    it 'returns team id of lowest win percentage against givin team' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"15", 
          outcome:"home win OT"
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"15",
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030223, 
          away_team_id: "6", 
          home_team_id:"15", 
          outcome: "away win REG"
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "15",
          home_team_id:"6", 
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "3",
          home_team_id:"15",
          outcome:"away win OT"
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "3",
          home_team_id:"15",
          outcome:"away win REG"
        })
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_lowest_win_percentage_against_the_given_team("3"))
      .to eql("15")

    end
  end

  describe '#team_id_highest_win_percentage_against_the_given_team' do
    it 'returns team id of highest win percentage against givin team' do
      
      games = [
        build_game({ 
          game_id: 2012030221,
          away_team_id: "3",
          home_team_id:"15", 
          outcome:"home win OT"
        }),
        build_game({ 
          game_id: 2012030222,
          away_team_id: "6",
          home_team_id:"15",
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030223, 
          away_team_id: "6", 
          home_team_id:"15", 
          outcome: "away win REG"
        }),
        build_game({ 
          game_id: 2012030224,
          away_team_id: "3",
          home_team_id:"6", 
          outcome:"away win REG"
        }),
        build_game({ 
          game_id: 2012030225,
          away_team_id: "3",
          home_team_id:"15",
          outcome:"away win OT"
        }),
        build_game({ 
          game_id: 2012030226,
          away_team_id: "3",
          home_team_id:"15",
          outcome:"away win REG"
        })
      ]
      games_repo = GamesRepo.new('stat_tracker_placeholder', games)

      expect(games_repo.team_id_highest_win_percentage_against_the_given_team("3"))
        .to eql("6")
    end
  end

  describe '#biggest_team_blowout' do
   
    team_id = "1"

    away_team_id = "2"

        games = [
          build_game({
            game_id: 11, 
            away_team_id: team_id, 
            home_team_id: away_team_id,
            away_goals:1,
            home_goals:0
          }),
          build_game({
            game_id: 12, 
            away_team_id: team_id, 
            home_team_id: away_team_id,
            away_goals:0,
            home_goals:1
          }),
          build_game({
            game_id: 13, 
            away_team_id: team_id, 
            home_team_id: away_team_id,
            away_goals:3,
            home_goals:1
          }),
          build_game({
            game_id: 14, 
            away_team_id: away_team_id, 
            home_team_id: team_id,
            away_goals:3,
            home_goals:0
          }),
        ]
    
    it'returns biggest win difference between team goals and opponent goals' do   

      

      stat_tracker = double()

      stat_tracker.stub(:games_won_by_given_team).with(team_id) { [11,13]}


      games_repo = GamesRepo.new(stat_tracker, games)

      expect(games_repo.biggest_team_blowout(team_id)).to eql(2)

    end

    it'returns biggest win difference between team goals and opponent goals' do   

      

      stat_tracker = double()

      stat_tracker.stub(:games_won_by_given_team).with(away_team_id) { [12,14]}


      games_repo = GamesRepo.new(stat_tracker, games)
      
      expect(games_repo.biggest_team_blowout(away_team_id)).to eql(3)
    end
  end



end
