class CaridsController < ApplicationController
    
    def index
        if (params[:company])
            @carids = Carid.where(company:params[:company]).order("number").page(params[:page]).per(10)
        else
            @carids = Carid.all.order("created_at DESC").page(params[:page]).per(10)
        end
    end
    
    def ordered
        @companies = Carid.all.pluck(:company).uniq.sort
    end
    
    def new
        @carid = Carid.new
    end
    
    def create
        @carid = Carid.new(carid_params)
       if (@carid.save) 
           redirect_to admin_url
       else
           render 'new'
       end
    end
    
    def edit
        @carid = Carid.find(params[:id])
    end
    
    def update
        @carid = Carid.find(params[:id])
        if (@carid.update(carid_params))
           redirect_to carids_url
        else
           render 'edit'
        end
    end
    
    def carte
        @carid = Carid.find(params[:id])
        @microposts = @carid.microposts.order("created_at DESC").page(params[:page]).per(10)
    end
    
    def allmap
        if (params[:company])
           @carids = Carid.where(company:params[:company]).pluck(:id)
           @microposts = Micropost.where(carid_id: @carids)
        else
            @microposts = Micropost.all
        end
    end
    
    private
    def carid_params
        params.require(:carid).permit(:company, :number)
    end
end
