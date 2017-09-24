class StaticPagesController < ApplicationController
  def home
    if params[:carid] != nil
      @car = Carid.find_by(id: params[:carid])
      @micropost = @car.microposts.build if @car != nil
    else
      #if logged_in?
    end
  end
end
