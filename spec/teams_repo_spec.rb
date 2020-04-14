require 'rspec'
require './lib/team'
require './lib/teams_repo'

def default_team_params
  {
    team_id: 6,
    franchiseid: 6,
    shortname: "Boston",
    teamname: "Bruins",
    abbreviation: "BOS" ,
    link: "/api/v1/teams/6"
  }
end

def build_team(override_params = {})
  Team.new(default_team_params.merge(override_params))
end

RSpec.describe TeamsRepo do
  describe '::count_of_teams' do
    teams = [
        build_team({ team_id: 1}),
        build_team({ team_id: 2}),
        build_team({ team_id: 3}),
      ]

    it 'returns total number of teams' do
      teams_count = TeamsRepo.count_of_teams(teams)

      expect(teams_count).to eql(3)
    end
  end

    describe '#best_offense' do
    
      team_one = 1
      team_two = 2
      team_one_name = "Blackhawks"
      team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

    it 'returns team name with the best offense' do
      stat_tracker = double()
      
      result  = {name: team_one_name}

      stat_tracker
        .stub(:team_id_with_highest_number_of_goals_per_game){team_one}

      teams_repo = TeamsRepo.new(stat_tracker,teams)

      expect(teams_repo.best_offense).to eql(result)
    end
  end

  describe '#worst_offense' do
    
    team_one = 1
    team_two = 2
    team_one_name = "Blackhawks"
    team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

    it 'returns team name with the worst offense' do
      stat_tracker = double()

      result  = {name: team_two_name}

      stat_tracker
        .stub(:team_id_with_lowest_number_of_goals_per_game) {team_two}

      teams_repo = TeamsRepo.new(stat_tracker,teams)

      expect(teams_repo.worst_offense).to eql(result)
    end
  end

  describe '#best_defense' do
    
    team_one = 1
    team_two = 2
    team_one_name = "Blackhawks"
    team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

    it 'returns team name with the best defense' do
      stat_tracker = double()

      result  = {name: team_two_name}

      stat_tracker
        .stub(:team_id_with_lowest_number_of_goals_allowed_per_game) {team_two}

      teams_repo = TeamsRepo.new(stat_tracker,teams)

      expect(teams_repo.best_defense).to eql(result)
    end
  end
  describe '#worst_defense' do
    
    team_one = 1
    team_two = 2
    team_one_name = "Blackhawks"
    team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

    it 'returns team name with the worst defense' do
      stat_tracker = double()

      result  = {name: team_one_name}

      stat_tracker
        .stub(:team_id_with_highest_number_of_goals_allowed_per_game) {team_one}

      teams_repo = TeamsRepo.new(stat_tracker,teams)

      expect(teams_repo.worst_defense).to eql(result)
    end
  end
  describe '#highest_scoring_visitor' do
    
    team_one = 1
    team_two = 2
    team_one_name = "Blackhawks"
    team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

    it 'returns team name of the highest scoring away team' do
      stat_tracker = double()

      result  = {name: team_one_name}

      stat_tracker
        .stub(:team_id_with_highest_score_per_game_when_away) {team_one}

      teams_repo = TeamsRepo.new(stat_tracker,teams)

      expect(teams_repo.highest_scoring_visitor).to eql(result)
    end
  end
  describe '#highest_scoring_home_team' do
    
    team_one = 1
    team_two = 2
    team_one_name = "Blackhawks"
    team_two_name = "Rangers"
      
    teams = [
        build_team({ team_id:team_one,teamname: team_one_name}),
        build_team({ team_id:team_two , teamname: team_two_name}),
    ]

      it 'returns team name of the highest scoring home team' do
        stat_tracker = double()

        result  = {name: team_two_name}

        stat_tracker
          .stub(:team_id_with_highest_score_per_game_when_home) {team_two}

        teams_repo = TeamsRepo.new(stat_tracker,teams)

        expect(teams_repo.highest_scoring_home_team).to eql(result)
      end
  end
end


