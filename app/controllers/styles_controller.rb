require "sass"
require "engines/bootstrap"

class StylesController < ApplicationController
  # TODO: call this whole thing boostrap_controller
  ELEMENTS = [
    'body background',
    'disabled input & button background, input addon background, nav & tabs & pagination link hover background, jumbotron background',
    'disabled link color, input placeholder color, dropdown header color, navbar inverse & link color',
    'nav tab link hover color',
    'link color, primary button background, pagination active background, progress bar background, label background, panel heading color',
    'text color, legend color, dropdown link color, panel text color, code color',
    'navbar inverse background'
  ]

  def new
    @url = params[:image_url].presence || ActionController::Base.helpers.asset_path("default.jpg")
    @colors = Engines::Bootstrap.extract_colors(params[:image_url])

    compile

    render "bootstrap", layout: "bootstrap"
  end

  def customize
    compile
  end

  def preview
    compile

    render "preview", layout: "bootstrap"
  end

  private

  def compile
    parse_colors

    engine = Engines::Bootstrap.new(@colors)
    @variables = engine.variables
    @lavishCSS = engine.compile
  end

  def parse_colors
    @colors ||= if params[:colors]
      params[:colors].map { |color| color.match(/^#/) ? color : "##{color}" }
    else
      Engines::Bootstrap::DEFAULT_COLORS
    end
  end
end
