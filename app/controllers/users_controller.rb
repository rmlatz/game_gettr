class UsersController < ApplicationController
  before_action :require_signin, except: [:index, :new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_user, except: [:index, :list, :start, :new, :create]


  def index
    unless !signed_in?
      redirect_to start_path
    end
  end

  def new
    @user = User.new
  end

  def create
    # Sets up a new user using the params passed from the form.
    @user = User.new(user_params)
    # If the user is able to be saved and there are no validation errors, call the sign in method (sessions helper) on the new user and redirect them to the homepage.
    if @user.save
      sign_in @user
      redirect_to root_path
      # Otherwise send them back to the new user form.
    else
      render :new
    end
  end

  def start
    @question_1_answers = [["I Want it All", 'all'], ["I Need to be Where the Action is", 'action'], ["I'm Going on an Adventure", 'adventure'], ["Quarters!", 'arcade'],
      ["My Kids are Watching", 'children%27s'], ["Fun for the Whole Family", 'family'], ["Kickpuncher!", 'fighting'], ["I Believe I Can Fly!", 'flight'], ["Suprise Me", 'other+games/compilations'], ["I'll Take the Case", 'puzzle'],
      ["Vrooooooom", 'racing'], ["Lightning Bolt!!!", 'role+playing'], ["Pew Pew Pew", 'shooter'], ["Like Real life, Only Not", 'simulation'], ["The Roar of the Crowd", 'sport+games'], ["A Brilliant Mind", 'strategy']]
    @question_2_answers = [['Show me EVERYTHING!', 'all'], ['Nintento DS', 'ds'], ["Nintendo GameCube", 'gc'], ["PC", 'pc'], ["PS2", 'ps2'], ["PS3", 'ps3'], ["PSP", 'psp'], ["Nintendo Wii", 'wii'], ["XBox", 'xbox'],
      ["XBox 360", 'xbox360'], ["Sega DreamCast", 'dc'], ["Gameboy", 'gameboy'], ["Gameboy Advanced", 'gba'], ["Sega Genesis", 'genesis'], ["Nintendo 64", 'n64'], ["NES", 'nes'], ["PS1", 'ps1'], ["Sega Saturn", 'saturn'],
      ["Super Nintendo", 'snes']]
    @question_3_answers = [["New is Better", 'newest'],["Classics First", 'oldest'],["A-Z", 'a-z'],["Z-A", 'z-a']]
  end


  def list
    list = HTTParty.get("http://api.gamesradar.com/games?genre=#{params[:genre]}&platform=#{params[:platform]}&sort=#{params[:sort]}&api_key=#{ENV['game_radar_api_key']}&page_size=50")
    @games_list = list["games"]["game"]

    if @games_list.blank?
      flash[:error] = "Sorry, our robots couldn't find a darn thing, \nrest assured they are being punished."
      redirect_to start_path
    end
  end


  private

    # Finds the user based on their ID in params
    def find_user
      @user = User.find(params[:id])
    end

    # Sets what are valid user params to be used in the new & edit methods.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Defines a method used as a before action that requires a user to be the current user to perform certain actions.
    def require_current_user
      if !current_user?(@user)
        redirect_to root_path
      end
    end

end
