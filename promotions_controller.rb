class PromotionsController < ApplicationController

  before_action :authenticate_user!

    def promotions
        @promotions = Promotion.all
        render:promotions
    end

    def new
        @promotions = Promotion.new
        if current_user.nil?
          redirect_to promotions_url, :flash => {:error => "You do not have access to this page"}
        elsif current_user.manager_role?
          render :new
        else 
          redirect_to promotions_url, :flash => {:error => "You do not have access to this page"}
        end
    end


    def create
        @promotions = Promotion.new(params.require(:promotion).permit(:title, :discount_flat, :discount_percent, :promo_code, :service_type, :service_id))
        if @promotions.save
          flash[:success] = "New promotion added!"
          redirect_to managerhome_url
        else
          flash.now[:error] = "Unable to create promotion"
          render :new
        end
      end


end
