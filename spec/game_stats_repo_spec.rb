require 'rspec'
require './lib/game_stat'
require './lib/game_stats_repo'

def default_stat_params
  {
    game_id: 2012030221,
    team_id: "6",
    home_or_away: "home",
    won: TRUE,
    settled_in: "OT",
    head_coach: "Claude Julien" ,
    goals: 3 ,
    shots: 48 ,
    hits: 51 ,
    pim: 6 ,
    power_play_oppurtunities: 4 ,
    power_play_goals: 1 ,
    face_off_win_percentage: 55.2 ,
    giveaways: 4 ,
    takeaways: 5
  }
end

def build_stat(override_params = {})
  GameStat.new(default_stat_params.merge(override_params))
end

RSpec.describe GameStatsRepo do
  describe '#team_id_with_highest_average_of_goals_per_game' do
    it 'returns id of team with the highest average of goals per game across all seasons' do
      stats = [
        build_stat({ game_id: 2012030222,team_id: "1", goals: 4}),
        build_stat({ game_id: 2012030223,team_id: "2", goals: 5}),
        build_stat({ game_id: 2012030224,team_id: "3", goals: 6}),
        build_stat({ game_id: 2012030225,team_id: "4", goals: 2}),
        build_stat({ game_id: 2012030226,team_id: "5", goals: 1}),
        build_stat({ game_id: 2012030227,team_id: "5", goals: 6}),
      ]

      game_stats_repo = GameStatsRepo.new('stat_tracker_placeholder', stats)

      expect(game_stats_repo.team_id_with_highest_average_of_goals_per_game).to eql("3")
    end
  end

  describe '#team_id_with_lowest_average_of_goals_per_game' do
    it 'returns id of team with the lowest average of goals per game across all seasons' do
      stats = [
        build_stat({ game_id: 2012030222,team_id: "1", goals: 4}),
        build_stat({ game_id: 2012030223,team_id: "2", goals: 5}),
        build_stat({ game_id: 2012030224,team_id: "3", goals: 6}),
        build_stat({ game_id: 2012030225,team_id: "4", goals: 2}),
        build_stat({ game_id: 2012030226,team_id: "5", goals: 1}),
        build_stat({ game_id: 2012030227,team_id: "5", goals: 6}),
      ]

      game_stats_repo = GameStatsRepo.new('stat_tracker_placeholder', stats)

      expect(game_stats_repo.team_id_with_lowest_average_of_goals_per_game).to eql("4")
    end
  end

  describe '#team_id_with_highest_percent_wins' do
    it 'returns id of team with highest percent wins across all seasons' do
      stats = [
        build_stat({ game_id: 2012030221,team_id: "1", goals: 6, won: TRUE,}),
        build_stat({ game_id: 2012030221,team_id: "2", goals: 1, won: TRUE,}),
        build_stat({ game_id: 2012030225,team_id: "2", goals: 5, won: TRUE,}),
        build_stat({ game_id: 2012030225,team_id: "5", goals: 4, won: FALSE,}),
        build_stat({ game_id: 2012030227,team_id: "5", goals: 2, won: FALSE,}),
        build_stat({ game_id: 2012030227,team_id: "1", goals: 4, won: FALSE,}),
      ]

      game_stats_repo = GameStatsRepo.new('stat_tracker_placeholder', stats)

      expect(game_stats_repo.team_id_with_highest_percent_wins).to eql("2")
    end
  end

  describe '#team_id_with_lowest_percent_wins' do
    it 'returns id of team with highest percent wins across all seasons' do
      stats = [
        build_stat({ game_id: 2012030221,team_id: "1", goals: 6, won: TRUE,}),
        build_stat({ game_id: 2012030221,team_id: "2", goals: 1, won: TRUE,}),
        build_stat({ game_id: 2012030225,team_id: "2", goals: 5, won: TRUE,}),
        build_stat({ game_id: 2012030225,team_id: "5", goals: 4, won: FALSE,}),
        build_stat({ game_id: 2012030227,team_id: "5", goals: 2, won: FALSE,}),
        build_stat({ game_id: 2012030227,team_id: "1", goals: 4, won: FALSE,}),
      ]

      game_stats_repo = GameStatsRepo.new('stat_tracker_placeholder', stats)

      expect(game_stats_repo.team_id_with_lowest_percent_wins).to eql("5")
    end
  end
end
