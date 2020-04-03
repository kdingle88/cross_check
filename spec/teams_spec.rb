require 'rspec'
require './lib/team'
require './lib/teams'

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

RSpec.describe Teams do
  describe '#count_of_teams' do
    context 'when given teams' do
      three_teams = [team_uno, team_tres, team_cinco]
      
      five_teams = [team_uno,team_dos,team_tres, team_quatro, team_cinco]

      it 'returns total number of teams' do
        three_teams_count = Teams.count_of_teams(three_teams)

        expect(three_teams_count).to eql(3)
      end

      it 'returns total number of teams test 2' do
        five_teams_count = Teams.count_of_teams(five_teams)

        expect(five_teams_count).to eql(5)
      end
    end
  end

  describe '#best_offense' do
    context 'when given teams and games' do
      three_teams = [team_uno, team_tres, team_cinco]
      
      five_teams = [team_uno,team_dos,team_tres, team_quatro, team_cinco]

      it 'returns name of the team with the highest average number of goals scored per game across all seasons' do
        
      end
    end
  end
end