class StaticPagesController < ApplicationController
  before_filter :update_awkipoststreams, :only => [:home, :refreshawkiposts]
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

  def votedup
 @awkipost = Awkipost.find(params[:id])
 @awkipost.ups=@awkipost.ups+1
 @awkipost.save
 render :text => "<div class='up'></div>"+@awkipost.ups.to_s+" likes"
 end

 def voteddown
 @sawkipost = Awkipost.find(params[:id])
 @awkipost.downs=@awkipost.downs+1
 @awkipost.save
 render :text => "<div class='down'></div>"+@awkipost.downs.to_s+" dislikes"
 end

  def refreshawkiposts
  render :partial => 'awkiposts.html.erb', :locals => { :awkiposts_streams => @awkiposts_streams }
  end

  protected
  def update_awkipoststreams
  @awkiposts_streams = Awkipost.order('created_at DESC').all
  end 
end
