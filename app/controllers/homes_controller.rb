class HomesController < ApplicationController
  def index 
 
    @session=session[:name]
  end
end
