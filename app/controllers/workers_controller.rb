class WorkersController < ApplicationController

  before_action :set_user, :except => [:index, :create, :new]

  def index
    @users = User.all.order(:name).paginate(page: params[:page])
  end

  def create
    if User.where(:email => user_params[:email]).size > 0
      @user = User.new user_params
      flash.now[:danger] = "Email '#{@user.email}' is already associated with a worker"
      render 'new'
    else
      User.create user_params
      flash[:success] = 'User created successfully'
      redirect_to workers_path
    end
  end

  def update    
    @user.update_attributes user_params
    flash[:success] = 'User updated successfully'
    redirect_to workers_path
  end

  def destroy
    name = @user.name
    @user.destroy
    flash[:success] = "User '#{name}' deleted  successfully"
    redirect_to workers_path
  end

  def new
    @user = User.new
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :expertise_level)
  end

end
