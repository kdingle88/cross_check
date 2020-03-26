class Game_Stat
  attr_reader :game_id, :team_id, :home_or_away, :won, :settled_in, :head_coach, :goals, :shots, :hits, :pim, :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways

  def initialize(game_stat)
    @game_id = game_stat[:game_id]
    @team_id = game_stat[:team_id]
    @home_or_away = game_stat[:HoA]
    @won = game_stat[:won]
    @settled_in = game_stat[:settled_in]
    @head_coach = game_stat[:head_coach]
    @goals = game_stat[:goals]
    @shots = game_stat[:shots]
    @hits = game_stat[:hits]
    @pim = game_stat[:pim]
    @power_play_opportunities = game_stat[:powerPlayOpportunities]
    @power_play_goals = game_stat[:powerPlayGoals]
    @face_off_win_percentage = game_stat[:faceOffWinPercentage]
    @giveaways = game_stat[:giveaways]
    @takeaways = game_stat[:takeaways]
  end
end