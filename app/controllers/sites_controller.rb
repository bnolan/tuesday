class SitesController < ApplicationController
  before_action :authenticate_user!

  def new
    @site = Site.new
  end

  def create
    @site = current_user.sites.build site_params

    if @site.save
      redirect_to @site
    else
      render :action => 'new'
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  protected

  def site_params
    params.require(:site).permit(:name, :subdomain)
  end
end