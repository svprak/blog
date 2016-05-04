class WelcomesController < ApplicationController
  def index
    if logged_in?
      redirect_to articles_path     
    end
  end

end
