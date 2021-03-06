class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
   @carids = nil
   if (params[:company])
       @carids = Carid.where(company:params[:company]).order("created_at DESC").page(params[:page]).per(10)
   else
       @carids = Carid.all.order("created_at DESC").page(params[:page]).per(10)
   end
  end
  
  def ordershow
    @user = User.find(params[:id])
    carids_array = [];
    if (params[:company])
        carids_array = Carid.joins(:microposts).includes(:microposts).where(company:params[:company]).sort {
            |a, b| b.microposts.last.created_at <=> a.microposts.last.created_at
        }
    else
        carids_array = Carid.joins(:microposts).includes(:microposts).all.sort {
            |a, b| b.microposts.last.created_at <=> a.microposts.last.created_at
        }
    end
    @carids = Kaminari.paginate_array(carids_array).page(params[:page]).per(10)

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


