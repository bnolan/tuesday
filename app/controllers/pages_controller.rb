class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_site

  def show
    @page = @site.pages.find(params[:id])
  end

  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy
    flash[:message] = "Page deleted"
    redirect_to [@site, @site.home_page]
  end

  
  def edit
    @site = Site.find(params[:site_id])
    @page = Page.find(params[:id])
  end

  def update
    @site = Site.find(params[:site_id])
    @page = Page.find(params[:id])

    @page.update_attributes! page_params

    render :json => { :success => true }
  end

  def create
    @page = @site.pages.create! page_params
  end

  protected

  def load_site
    @site = current_user.sites.find(params[:site_id])
  end

  def page_params
    params.require(:page).permit(:title, :path, :position, :content)
  end

end

