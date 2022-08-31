class Api::V1::SearchesController < ApplicationController

  def find_all
    if params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%")
      if !items.nil?
        render json: ItemSerializer.new(items)
      else
        render json: { data: { message: 'No Match Found' } } 
      end
    else
      render status: 404
    end
  end
end
