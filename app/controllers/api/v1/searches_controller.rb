class Api::V1::SearchesController < ApplicationController

  def find_all
    if params[:name]
      items = Item.items_name_match(params[:name])
      check_for_nil_items(items)
    elsif params[:min_price]
      items = Item.items_min_price_match(params[:name])
      check_for_nil_items(items)
    elsif params[:max_price]
      items = Item.items_max_price_match(params[:max_price])
      check_for_nil_items(items)
    end
  end

  def find_one_merchant
    if params[:name]
      merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").order(:name).first
      check_for_nil_merchant(merchant)
    end
  end


  private
    def error_rendering
      render json: { data: [], message: 'No Matches Found'} 
    end

    def check_for_nil_items(items)
      if items != []
        render json: ItemSerializer.new(items)
      else
        error_rendering
      end
    end

    def check_for_nil_merchant(merchant)
      if !merchant.nil?
        render json: MerchantSerializer.new(merchant)
      else
        render json: { data: {}, message: 'No Matches Found'} 
      end
    end
end
