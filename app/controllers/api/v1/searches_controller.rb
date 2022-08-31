class Api::V1::SearchesController < ApplicationController

  def find_all
    require 'pry'; binding.pry 
    if params[:name]
      items = Item.where("name ILIKE ?", "%#{params[:name]}%")
    else
      render status: 404
    end
  end
end
