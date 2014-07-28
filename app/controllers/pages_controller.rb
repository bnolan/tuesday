class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_site

  def new
    @page = Page.new
  end

  def create
    @page = @site.pages.build page_params

    if @page.save
      redirect_to [@site, @page]
    else
      render :action => 'new'
    end
  end

  def show
    @page = @site.pages.find(params[:id])
  end

  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy
    flash[:notice] = "Page deleted"
    redirect_to [@site, @site.home_page]
  end

  
  def edit
    @page = @site.pages.find(params[:id])
  end

  def update
    @page = @site.pages.find(params[:id])

    @page.update_attributes! page_params

    respond_to do |format|
      format.json do
        render :json => { :success => true }
      end
      format.html do
        redirect_to [@site, @page]
      end
    end
  end

  protected

  def load_site
    @site = current_user.sites.find(params[:site_id])
  end

  def page_params
    params.require(:page).permit(:name, :path, :position, :content)
  end

end

