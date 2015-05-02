class StylesController < ApplicationController
  DEFAULT_COLORS = ["#D4D8D1", "#A8A8A1", "#AA9A66", "#B74934", "#577492", "#67655D", "#332C2F"]
  def new
    if params[:image_url].blank?
      @url = "https://scontent.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/163026_481734701986_7179594_n.jpg?oh=202f20cc33e6530a1a8a287d1dc1908b&oe=5599A631"
      @colors = DEFAULT_COLORS
    else
      @url = params[:image_url]
      begin
        extr = Prizm::Extractor.new(@url)
        @colors = extr.get_colors(7, false).sort { |a, b| b.to_hsla[2] <=> a.to_hsla[2] }.map { |p| extr.to_hex(p) }
        extr = nil
      rescue
        @colors = DEFAULT_COLORS
      end
    end

    bootstrap

    render "bootstrap-3.0.0", layout: "bootstrap-3.0.0"
  end

  def customize
    bootstrap
  end

  def preview
    bootstrap

    render "preview", layout: "bootstrap-3.0.0"
  end

  private

  def bootstrap
    parse_colors

    @variables = Lavish::Application::VARIABLES
    @variables.gsub!(/(@body-bg:\s+)[^;]+/i, '\1' + @colors[0].downcase)
    @variables.gsub!(/(@gray-lighter:\s+)[^;]+/i, '\1' + @colors[1].downcase)
    @variables.gsub!(/(@gray-light:\s+)[^;]+/i, '\1' + @colors[2].downcase)
    @variables.gsub!(/(@gray:\s+)[^;]+/i, '\1' + @colors[3].downcase)
    @variables.gsub!(/(@gray-dark:\s+)[^;]+/i, '\1' + @colors[5].downcase)
    #variables.gsub!(/(@gray-darker:\s+)[^;]+/i, '\1' + @colors[6].downcase)

    @variables.gsub!(/(@brand-primary:\s+)[^;]+/i, '\1' + @colors[4].downcase)
    @variables.gsub!(/(@navbar-inverse-bg:\s+)[^;]+/i, '\1' + @colors[6].downcase)
    @variables.gsub!(/(@table-border-color:\s+)[^;]+/i, '\1' + @colors[5].downcase)

    @less = @variables + Lavish::Application::BOOTSTRAP
  end

  def parse_colors
    @colors ||= if params[:colors]
      params[:colors].map { |color| color.match(/^#/) ? color : "##{color}" }
    else
      DEFAULT_COLORS
    end
  end
end
