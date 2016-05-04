class WelcomesController < ApplicationController
  def home
    if logged_in?
      redirect_to articles_path
    else
      redirect_to root_path
    end
  end

end
