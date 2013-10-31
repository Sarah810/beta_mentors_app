class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :all_mentees]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to Succeed America, #{@user.name}!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def all_mentees
    @mentees = User.where("Role = 'Mentee'")
  end

  def all_mentors
    @mentors = User.where("Role = 'Mentor'")
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :language, :role)
    end

    # Before filters

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

end
