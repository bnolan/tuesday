class Compiler
  require 'fileutils'

  def initialize(site)
    @site = site
    FileUtils.mkdir_p(path)
    remove_files
    create_stylesheet
    create_pages
  end

  def path
    Rails.root.join("public", "sites", @site.subdomain)
  end

  def remove_files
    Dir.glob(path.join("*")).each do |file|
      File.delete(path.join(file))
    end
  end

  def create_stylesheet
    File.open(path.join("stylesheet.css"), "w") do |f|
      f.puts render_stylesheet
    end
  end

  def render_stylesheet
    Sass::Engine.new(stylesheet_markup, :syntax => :scss).render
  end

  def stylesheet_markup
    @site.theme.stylesheet
  end

  def create_pages
    @site.pages.each do |page|
      File.open(path.join(page.path + ".html"), "w") do |f|
        f.puts render_page(page)
      end
    end
  end

  def render_page(page)
    liquid_template.render 'pages' => @site.pages, 'page' => page, 'site' => @site
  end

  def liquid_template
    @liquid_template ||= Liquid::Template.parse(template_markup)
  end

  def template_markup
    @site.theme.template
  end
end