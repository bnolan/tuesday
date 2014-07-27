class ThemesController < ApplicationController
  before_filter :load_site

  def update
    @theme = Theme.find(params[:id])
    @theme.update_attributes! theme_params
    Compiler.new @site

    redirect_to edit_theme_path(@theme)
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  protected

  def theme_params
    params.require(:theme).permit(:stylesheet, :name, :template)
  end

  def load_site
    @site = Site.find(2)
  end
end
