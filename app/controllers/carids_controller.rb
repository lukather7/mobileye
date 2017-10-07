class CaridsController < ApplicationController
    
    def index
        @carids = Carid.all.order("created_at DESC").page(params[:page]).per(10)
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
    
    private
    def carid_params
        params.require(:carid).permit(:company, :number)
    end
end
