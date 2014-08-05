class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_site

  def create
    @image = @site.images.create! image_params

    render :json => { :success => true, :image => @image.image.url(:medium) }
  end

  protected

  def load_site
    @site = current_user.sites.find(params[:site_id])
  end

  def image_params
    params.require(:image).permit(:image)
  end

end
