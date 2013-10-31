class UsersController < ApplicationController
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

end
