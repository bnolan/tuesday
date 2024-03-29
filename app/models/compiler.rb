class Compiler
  require 'fileutils'

  def initialize(site)
    @site = site
    FileUtils.mkdir_p(path)
    FileUtils.mkdir_p(path.join("images"))
  end

  def compile(page=nil)
    if page
      create_pages([page])
      create_index
      copy_images
    else
      remove_files
      create_stylesheet
      create_pages(@site.pages)
      create_index
      copy_images
    end
  end

  def path
    Rails.root.join("public", "sites", @site.subdomain)
  end

  def remove_files
    Dir.glob(path.join("*")).each do |file|
      if File.directory?(path.join(file))
        # should just be /images
      else
        File.delete(path.join(file))
      end
    end

    Dir.glob(path.join("images", "*")).each do |file|
      File.delete(path.join(file))
    end
  end

  def copy_images
    @site.images.each do |image|
      FileUtils.copy_file Rails.root.join('public', image.image.url(:medium).sub(/\?.+/,'').slice(1,64000)), path.join("images", "#{image.id}-#{image.friendly_name}.#{image.extension}")
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
    if @site.theme
      @site.theme.stylesheet
    elsif @site.stylesheet
      @site.stylesheet
    else
      Compiler.default_stylesheet
    end
  end

  def self.default_stylesheet
    @default_stylesheet ||= IO.readlines(Rails.root.join("lib", "templates", "template.scss")).join
  end

  def template_markup
    if @site.theme
      @site.theme.template
    elsif @site.template
      @site.template
    else
      Compiler.default_template
    end
  end

  def self.default_template
    @default_template ||= IO.readlines(Rails.root.join("lib", "templates", "template.liquid")).join
  end

  def create_index
    File.open(path.join("index.html"), "w") do |f|
      f.puts render_page(@site.pages.first)
    end
  end

  def create_pages(pages)
    pages.each do |page|
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
end