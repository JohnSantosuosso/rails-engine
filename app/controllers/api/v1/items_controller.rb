class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    else
      render json: { data: {errors: item.errors.full_messages } }
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      item.destroy_invoice_if_one_item
      render status: 204
    else
      render status: 404
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end