class Api::V1::SearchesController < ApplicationController

  def find_all
    if params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%")
      if items = []
        render json: { data: { message: 'No Item Found' } }
      else
        render json: ItemSerializer.new(items)
      end
    else
      render status: 404
    end
  end
end
