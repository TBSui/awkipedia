class AwkipostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def create
  	@awkipost = current_user.awkiposts.build(awkipost_params)
    if @awkipost.save
      flash[:success] = "Awkipost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @awkipost.destroy
    redirect_to root_url
  end

  private

    def awkipost_params
      params.require(:awkipost).permit(:content)
    end

    def correct_user
      @awkipost = current_user.awkiposts.find_by(id: params[:id])
      redirect_to root_url if @awkipost.nil?
    end

end