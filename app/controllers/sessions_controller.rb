class SessionsController < ApplicationController
  skip_before_filter :ensure_user

  def create
    user = User.from_auth_hash(auth_hash)
    if user
      session['current_user_id'] = user.id
      redirect_to '/'
    else
      redirect_to login_failure_path
    end
  end

  def new
  end

  def failure
    flash[:error] = 'Email or password was incorrect'
    render :new
  end

  def destroy
    session['current_user_id'] = nil
    redirect_to '/'
  end

protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
