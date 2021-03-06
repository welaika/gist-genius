class SessionsController < ApplicationController

  def new
    redirect_to '/auth/github'
  end

  def sample
    sample_user = User.where(name: "Gist Genius").first
    session[:user_id] = sample_user.id
    redirect_to user_url(current_user), :notice => 'Signed in!'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    user.token = auth['credentials']['token']
    user.save
    session[:user_id] = user.id
    redirect_to user_url(current_user), :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
