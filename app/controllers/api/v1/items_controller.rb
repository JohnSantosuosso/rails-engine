class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    render json: Item.create(item_params) #need to change to save and add validations/sad path
  end

  def update
    require 'pry'; binding.pry 
    render json: Item.update(params[:id], item_params)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end