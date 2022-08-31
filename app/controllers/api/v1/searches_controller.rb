class Api::V1::SearchesController < ApplicationController

  def find_all
    if params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%")
      nil_check(items)
    elsif params[:min_price]
      items = Item.where("unit_price > ?", params[:min_price])
      nil_check(items)
    elsif params[:max_price]
      items = Item.where("unit_price < ?", params[:max_price])
      nil_check(items)
    end
  end


  private
    def error_rendering
      render json: { data: [], message: 'No Matches Found'} 
    end

    def nil_check(items)
      if items != []
        render json: ItemSerializer.new(items)
      else
        error_rendering
      end
    end
end
