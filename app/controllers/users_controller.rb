class UsersController < ApplicationController
  
  def show # 追加
   @user = User.find(params[:id])
   @carids = Carid.all.order("created_at DESC")
  end
    
  def new
   @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created"    
      redirect_to @user #これを追加    
    else
     render 'new'
    end
  end

  private

  def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end


