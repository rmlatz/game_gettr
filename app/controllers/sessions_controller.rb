# This controller will be used to create a new session for a newly signed in user.

class SessionsController < ApplicationController
# Renders the signin form.
  def new
  end

# Take the params from the new form and creates a new session for the signed in user.
  def create
    # Goes through the email index we create in out migration to find the user.
    user = User.find_by(email: params[:session][:email].downcase)

    # Looks to see IF the user was found
    # Also looks to see if user could be authenticated through the bcrypt gem method .authenticate.
    if user && user.authenticate(params[:session][:password])
      # Calls the sign_in method (in sessions helper) on the authenticated user making this user the current user.
      sign_in user
      # Sends the newly signed in user back to the page they were trying to access, or the homepage.
      redirect_back_or start_path
    else
      # If user was unable to be authenticated, returns them to the sign in page with errors.
      flash[:error] = 'Invalid email/password'
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
