module SessionsHelper

# Current User - Methods.

  def current_user
    # Assigns remember token the hash value of the remember token stored in user cookies.
    remember_token = User.hash(cookies[:remember_token])
    # Sets the current user to itself if it exists, or to the user with a matching remember token.
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user=(user)
    # Allows us to set the current user to a user we pass as a parameter.
    @current_user = user
  end

  def current_user?(user)
    # Allows checking if the passed user is the current user.
    # returns true or false.
    current_user == user
  end

# Sign-In - Methods

  def signed_in?
    # Allows us to determine if the current user is signed in.
    !current_user.nil?
  end

  def sign_in(user)
    # Uses the new_remember_token method to create a new remember token.
    remember_token = User.new_remember_token
    # Assigns this new remember token to users cookies for a duration of 20 years.
    cookies.permanent[:remember_token] = remember_token
    # Changes the placeholder hash value for the user in the DB to the hash value associated with the actual remember token.
    user.update_attribute(:remember_token, User.hash(remember_token))
    # Sets the newly signed in user as the current user.
    self.current_user = user
  end

  def sign_out
    # Overwrites the hash value in the DB from one associated with an actual remember token to a placeholder.
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    # Removes the remember token from the users cookies
    cookies.delete(:remember_token)
    # Sets the current user to nil (no one)
    self.current_user = nil
  end

# Desired Location - Methods

  def store_location
    # Checks to see if it has received a GET request from an unauthorized user.
    if request.get?
      # Stores the url requested in a hash with the key 'return_to'
      session[:return_to] = request.url
    end
  end

  def redirect_back_or(default)
    # Redirects a now signed in user back to their originally requested url.
    # Or to a provided default path.
    redirect_to(session[:return_to] || default)
    # Deletes the saved url as it is no longer needed.
    session.delete(:return_to)
  end

# Sign In Required - Mehtod

  def require_signin
    # If the user is not signed in:
    unless signed_in?
      # Calls the store_location method to save the url the unsigned in user was trying to navigate to:
      store_location
      # Establishes an error to display:
      flash[:error] = "You must be signed in to reach that page."
      # Sends the unsigned in user to the sign in page.
      redirect_to signin_path
    end
  end

end
