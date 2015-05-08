class GamesController < ApplicationController

  def game
    @youtube = "https://www.youtube.com/results?search_query="
    get_game_data(params[:title])
    @is_saved = current_user.games.find_by(title: @title)
  end

  def create
    title = params[:game][:title]
    if game = Game.find_or_create_by(title: title)
      Addition.create(user_id: current_user.id, game_id: game.id)
      redirect_to games_list_path
    else
      redirect_to '/game?title=' + "#{title}"
    end
  end

  def list
    @user_games = current_user.games
  end

  def destroy
    Game.destroy(params[:id])
    redirect_to games_list_path
  end


#-----------------------------------------------------------------------------------------------
  private
#-----------------------------------------------------------------------------------------------

    def get_game_data(title)
      title = title.gsub(" ", "+")
      @game = HTTParty.get("http://www.giantbomb.com/api/search/?api_key=#{ENV['giant_bomb_api_key']}&format=json&query=#{title}&resources=game&limit=1")
      @deck = @game["results"][0]["deck"]
      @image = @game["results"][0]["image"]["super_url"]
      @title = title
    end

end



### game = Game.find_or_create_by_title()
### current_user.games << game
