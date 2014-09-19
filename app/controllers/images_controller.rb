class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_site, :only => [:create]

  def show
    @image = Image.find(params[:id])

    raise ActiveRecord::RecordNotFound unless @image.site.user == current_user

    redirect_to @image.image.url(:medium)
  end

  def create
    @image = @site.images.create! image_params
    render :json => { :success => true, :image => "/images/#{@image.id}-#{@image.friendly_name}.#{@image.extension}" }
  end

  protected

  def load_site
    @site = current_user.sites.find(params[:site_id])
  end

  def image_params
    params.require(:image).permit(:image)
  end

end
