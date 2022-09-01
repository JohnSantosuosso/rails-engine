class Api::V1::SearchesController < ApplicationController

  def find_matching_items
    if params.keys.count == 3 && params[:name]
      items = Item.items_name_match(params[:name])
      check_for_nil_items(items)
    elsif params.keys.count == 3 && params[:min_price]
      items = Item.items_min_price_match(params[:min_price])
      check_for_nil_items(items)
    elsif params.keys.count == 3 && params[:max_price]
      items = Item.items_max_price_match(params[:max_price])
      check_for_nil_items(items)
    elsif params[:min_price] && params[:max_price]
      items = Item.items_min_max_price_match(params[:min_price], params[:max_price])
      check_for_nil_items(items)
    else
      render json: { data: {errors: "You have entered invalid search data" } }
    end
  end

  def find_matching_merchant
    if params[:name]
      merchant = Merchant.merchant_name_match_first(params[:name])
      check_for_nil_merchant(merchant)
    end
  end


  private
    def no_matches_found
      render json: { data: [], message: 'No Matches Found'} 
    end

    def check_for_nil_items(items)
      if items != []
        render json: ItemSerializer.new(items)
      else
        no_matches_found
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
