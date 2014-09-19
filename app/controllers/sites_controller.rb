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
    @site = current_user.sites.find(params[:id])
    redirect_to [@site, @site.home_page]
  end

  def theme
    @site = current_user.sites.find(params[:id])
  end

  def edit
    @site = current_user.sites.find(params[:id])
  end

  def update
    @site = current_user.sites.find(params[:id])
    @site.update_attributes! site_params
    @site.compile!
    flash[:notice] = "Site updated"

    respond_to do |format|
      format.js { render :action => 'update' }
      format.html { redirect_to @site }
    end
  end

  protected

  def site_params
    params.require(:site).permit(:name, :subdomain, :template, :stylesheet)
  end
end
