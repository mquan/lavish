class StylesController < ApplicationController
  def new
    if params[:image_url].blank?
      @url = "https://sphotos-b-sjc.xx.fbcdn.net/hphotos-frc3/184020_10150260094181987_6517626_n.jpg"
      @colors = ["#DEE7EE", "#BEBBAF", "#AC8F6A", "#8A7056", "#6E6352", "#4D4137", "#131415"]
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
