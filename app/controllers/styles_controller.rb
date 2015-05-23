require "sass"

class StylesController < ApplicationController
  # TODO: call this whole thing boostrap_controller
  DEFAULT_COLORS = ["#D4D8D1", "#A8A8A1", "#AA9A66", "#B74934", "#577492", "#67655D", "#332C2F"]
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
    if params[:image_url].blank?
      @url = ActionController::Base.helpers.asset_path("default.jpg")
      @colors = DEFAULT_COLORS.dup
    else
      @url = params[:image_url]
      begin
        extr = Prizm::Extractor.new(@url)
        @colors = extr.get_colors(7, false).sort { |a, b| b.to_hsla[2] <=> a.to_hsla[2] }.map { |p| extr.to_hex(p) }
        # Fill in default colors if parsed colors are less than 7
        extr = nil
      rescue
        @colors = DEFAULT_COLORS.dup
      end
    end

    bootstrap

    render "bootstrap", layout: "bootstrap"
  end

  def customize
    bootstrap
  end

  def preview
    bootstrap

    render "preview", layout: "bootstrap"
  end

  private

  def bootstrap
    parse_colors

    @variables = Lavish::Application::VARIABLES

    @variables.gsub!(/(\$body-bg:\s+)[^;]+/i, '\1' + @colors[0].downcase)
    @variables.gsub!(/(\$gray-lighter:\s+)[^;]+/i, '\1' + @colors[1].downcase)
    @variables.gsub!(/(\$gray-light:\s+)[^;]+/i, '\1' + @colors[2].downcase)
    @variables.gsub!(/(\$gray:\s+)[^;]+/i, '\1' + @colors[3].downcase)
    @variables.gsub!(/(\$gray-dark:\s+)[^;]+/i, '\1' + @colors[5].downcase)
    #variables.gsub!(/(@gray-darker:\s+)[^;]+/i, '\1' + @colors[6].downcase)

    @variables.gsub!(/(\$brand-primary:\s+)[^;]+/i, '\1' + @colors[4].downcase)
    @variables.gsub!(/(\$navbar-inverse-bg:\s+)[^;]+/i, '\1' + @colors[6].downcase)
    @variables.gsub!(/(\$table-border-color:\s+)[^;]+/i, '\1' + @colors[5].downcase)

    # @variables.gsub!(/(@body-bg:\s+)[^;]+/i, '\1' + @colors[0].downcase)
    # @variables.gsub!(/(@gray-lighter:\s+)[^;]+/i, '\1' + @colors[1].downcase)
    # @variables.gsub!(/(@gray-light:\s+)[^;]+/i, '\1' + @colors[2].downcase)
    # @variables.gsub!(/(@gray:\s+)[^;]+/i, '\1' + @colors[3].downcase)
    # @variables.gsub!(/(@gray-dark:\s+)[^;]+/i, '\1' + @colors[5].downcase)
    # #variables.gsub!(/(@gray-darker:\s+)[^;]+/i, '\1' + @colors[6].downcase)

    # @variables.gsub!(/(@brand-primary:\s+)[^;]+/i, '\1' + @colors[4].downcase)
    # @variables.gsub!(/(@navbar-inverse-bg:\s+)[^;]+/i, '\1' + @colors[6].downcase)
    # @variables.gsub!(/(@table-border-color:\s+)[^;]+/i, '\1' + @colors[5].downcase)

    # @less = @variables + Lavish::Application::BOOTSTRAP
    sass = @variables + Lavish::Application::BOOTSTRAP
    @less = @css = Sass::Engine.new(sass, syntax: :scss).render
  end

  def parse_colors
    @colors ||= if params[:colors]
      params[:colors].map { |color| color.match(/^#/) ? color : "##{color}" }
    else
      DEFAULT_COLORS
    end
  end
end
