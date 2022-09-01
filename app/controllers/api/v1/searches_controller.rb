class Api::V1::SearchesController < ApplicationController

  def find_matching_items
    if params[:name]
      items = Item.items_name_match(params[:name])
      check_for_nil_items(items)
    elsif params[:min_price]
      require 'pry'; binding.pry 
      items = Item.items_min_price_match(params[:min_price])
      check_for_nil_items(items)
    elsif params[:max_price]
      items = Item.items_max_price_match(params[:max_price])
      check_for_nil_items(items)
    end
  end

  def find_matching_merchant
    if params[:name]
      merchant = Merchant.merchant_name_match_first(params[:name])
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
