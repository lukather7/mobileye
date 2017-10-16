class MicropostsController < ApplicationController
 before_action :logged_in_user, only: [:do_map]  
 
  def create
   @car = Carid.find(params[:micropost][:carid_id])
   @micropost = @car.microposts.build(micropost_params)
   if @micropost.save
     flash[:success] = "記録に成功しました" 
     redirect_to root_url(carid: @car.id)
   else
     flash[:danger] = "記録できませんでした" 
#     redirect_to root_url(carid: @carid.id)
     params[:carid] = @car.id
     render 'static_pages/home', {carid: @car.id}
   end
  end
  
  def destroy
   @micropost = current_user.microposts.find_by(id: params[:id])
   return redirect_to root_url if @micropost.nil?
   @micropost.destroy
   flash[:success] = "Micropost deleted"
   redirect_to request.referrer || root_url
  end
  
  def do_map
   @micropost = Micropost.find(params[:id])
  end
  
  private
  def micropost_params
   params.require(:micropost).permit(:content, :kind, :lat, :lng, :accuracy, :carid_id, :logtime, :area)
  end
end 
    
