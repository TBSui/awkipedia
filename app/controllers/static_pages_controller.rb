class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @awkipost  = current_user.awkiposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
