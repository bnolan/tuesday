class PagesController < ApplicationController
  before_action :authenticate_user!
  require 'nokogiri'

  # THIS IS GROSS YO

  def show
    doc = Nokogiri::HTML(open(Rails.root.join "lib", "sample.html"))

    @page = { :id => 1 }

    index = 0
    @page[:elements] = doc.css('body *').to_a.collect do |el|
      { :id => index, :position => (index += 1), :uuid => "1234-1234-1234-%04d" % index, :content => "<#{el.node_name}>#{el.content}</#{el.node_name}>" }
    end

    @page = Page.first
    @pages = Page.all
  end

  def update
    @site = Site.find(params[:site_id])
    @page = Page.find(params[:id])

    @page.update_attributes! page_params

    render :json => { :success => true }
  end

  def create
    @site = Site.find(params[:site_id])
    @page = @site.pages.create! page_params

    render :json => { :success => true }
  end

  def page_params
    params.require(:page).permit(:title, :path, :position, :content)
  end

end
