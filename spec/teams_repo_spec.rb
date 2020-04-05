require 'rspec'
require './lib/team'
require './lib/teams_repo'
require './lib/stat_tracker'

game_path = './spec/fixtures/game.csv'
team_path = './spec/fixtures/team_info.csv'
game_teams_path = './spec/fixtures/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

#ADD NEW WAY OF CREATING CLASS INSTANCES WITH INFO BELOW

def default_team_params
  {
    team_id: 6,
    franchise_id: 6,
    short_name: "Boston",
    team_name: "Bruins",
    abbreviation: "BOS" ,
    link: "/api/v1/teams/6"
  }
end

def build_teams(override_params = {})
  Team.new(default_team_params.merge(override_params))
end

team_uno = Team.new({
  team_id:  "1",
  franchiseid: "23",
  shortname: "New Jersey",
  teamname: "Devils",
  abbreviation: "NJD",
  link: "/api/v1/teams/1"
})

team_dos = Team.new({
  team_id:  "6",
  franchiseid: "6",
  shortname: "Boston",
  teamname: "Bruins",
  abbreviation: "BOS",
  link: "/api/v1/teams/6"
})

team_tres = Team.new({
  team_id:  "3",
  franchiseid: "10",
  shortname: "NY Rangers",
  teamname: "Rangers",
  abbreviation: "NYR",
  link: "/api/v1/teams/3"
})

team_quatro = Team.new({
  team_id:  "10",
  franchiseid: "5",
  shortname: "Toronto",
  teamname: "Maple Leafs",
  abbreviation: "TOR",
  link: "/api/v1/teams/10"
})

team_cinco = Team.new({
  team_id:  "15",
  franchiseid: "24",
  shortname: "Washington",
  teamname: "Capitals",
  abbreviation: "WSH",
  link: "/api/v1/teams/15"
})

RSpec.describe TeamsRepo do
  describe '::count_of_teams' do
    context 'when given teams' do
      three_teams = [
        build_teams({ team_id: 1}),
        build_teams({ team_id: 3}),
        build_teams({ team_id: 5}),
      ]
      
      five_teams = [
        build_teams({ team_id: 1}),
        build_teams({ team_id: 2}),
        build_teams({ team_id: 3}),
        build_teams({ team_id: 4}),
        build_teams({ team_id: 5}),
      ]

      it 'returns total number of teams' do
        three_teams_count = TeamsRepo.count_of_teams(three_teams)

        expect(three_teams_count).to eql(3)
      end

      it 'returns total number of teams test 2' do
        five_teams_count = TeamsRepo.count_of_teams(five_teams)

        expect(five_teams_count).to eql(5)
      end
    end
  end

  # describe '#best_offense' do
  #   it 'returns name of team with the highest goals' do
  #     teams = [
  #       build_teams({ game_id: 2012030222,team_id: 1, goals: 4}),
  #       build_teams({ game_id: 2012030223,team_id: 2, goals: 5}),
  #       build_teams({ game_id: 2012030224,team_id: 3, goals: 6}),
  #       build_teams({ game_id: 2012030225,team_id: 4, goals: 2}),
  #       build_teams({ game_id: 2012030226,team_id: 5, goals: 1}),
  #       build_teams({ game_id: 2012030227,team_id: 5, goals: 6}),
  #     ]

  #     teams_repo = TeamsRepo.new(stat_tracker,)

    #   expect()
    # end
  # end
end