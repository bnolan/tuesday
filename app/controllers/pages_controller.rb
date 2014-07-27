class PagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @site = Site.find(params[:site_id])
    @page = Page.find(params[:id])
  end
  
  def edit
    @site = Site.find(params[:site_id])
    @page = Page.find(params[:id])
    # doc = Nokogiri::HTML(open(Rails.root.join "lib", "sample.html"))

    # @page = { :id => 1 }

    # index = 0
    # @page[:elements] = doc.css('body *').to_a.collect do |el|
    #   { :id => index, :position => (index += 1), :uuid => "1234-1234-1234-%04d" % index, :content => "<#{el.node_name}>#{el.content}</#{el.node_name}>" }
    # end

    # @page = Page.first
    # @pages = Page.all

    # if @path = params[:path]
    #   @site = Site.find(2)
    #   @pages = @site.pages
    #   @page = @pages.find_by_path(@path)

    #   # Liquid::Template.error_mode = :strict

    #   @template = Liquid::Template.parse(IO.readlines(Rails.root.join('templates', 'echo', 'template.liquid')).join("\n"))
    #   # @template = Liquid::Template.parse("{{ page.title }}")

    #   render :text => @template.render({
    #     'pages' => @pages,
    #     'site' => @site,
    #     'page' => @page,
    #     'path' => request.path
    #   })
    # else
    #   raise ActiveRecord::RecordNotFound
    # end
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
