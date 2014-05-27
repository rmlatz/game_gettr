class UsersController < ApplicationController
  before_action :require_signin, except: [:index, :new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_user, except: [:index, :start, :new, :create]


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
