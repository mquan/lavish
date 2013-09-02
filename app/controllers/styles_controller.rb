class StylesController < ApplicationController
  def new
    if params[:image_url].blank?
      @url = "https://sphotos-a-sjc.xx.fbcdn.net/hphotos-prn1/163026_481734701986_7179594_n.jpg"
      @colors = ["#D4D8D1", "#A8A8A1", "#AA9A66", "#B74934", "#577492", "#67655D", "#332C2F"]
    else
      @url = params[:image_url]
      begin
        extr = Prizm::Extractor.new(@url)
        @colors = extr.get_colors(7, false).sort { |a, b| b.to_hsla[2] <=> a.to_hsla[2] }.map { |p| extr.to_hex(p) }
        extr = nil
      rescue
        @colors = []
      end
    end

    bootstrap

    render layout: "bootstrap-3.0.0"
  end

  def customize
    @colors = params[:colors]
    bootstrap
  end

  private

  def bootstrap
    variables = Lavish::Application::VARIABLES
    variables.gsub!(/(@body-bg:\s+)[^;]+/i, '\1' + @colors[0].downcase)
    variables.gsub!(/(@gray-lighter:\s+)[^;]+/i, '\1' + @colors[1].downcase)
    variables.gsub!(/(@gray-light:\s+)[^;]+/i, '\1' + @colors[2].downcase)
    variables.gsub!(/(@gray:\s+)[^;]+/i, '\1' + @colors[3].downcase)
    variables.gsub!(/(@gray-dark:\s+)[^;]+/i, '\1' + @colors[5].downcase)
    #variables.gsub!(/(@gray-darker:\s+)[^;]+/i, '\1' + @colors[6].downcase)

    variables.gsub!(/(@brand-primary:\s+)[^;]+/i, '\1' + @colors[4].downcase)
    variables.gsub!(/(@navbar-inverse-bg:\s+)[^;]+/i, '\1' + @colors[6].downcase)
    variables.gsub!(/(@table-border-color:\s+)[^;]+/i, '\1' + @colors[5].downcase)

    @less = variables + Lavish::Application::BOOTSTRAP
  end
end
