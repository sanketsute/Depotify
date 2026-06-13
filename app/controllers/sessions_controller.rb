class SessionsController < ApplicationController

  skip_before_action :authorize, only: [:new, :create, :register, :register_create]
  def new
    
  end

  def register
    @user = User.new
    respond_to do |format|
      format.html { render :register }
      format.json { render :register, status: :ok }
    end
  end

  def register_create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to store_index_url, notice: "User was successfully created." }
        format.json { render :register, status: :created, location: @user } 
      else
        format.html { render :register, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    user = User.find_by_name(params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to store_index_url, notice: "Logged in!"
    else
    redirect_to login_url, alert: "Invalid name or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out!"
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
