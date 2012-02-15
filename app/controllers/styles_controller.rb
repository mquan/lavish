class StylesController < ApplicationController
  def set
    if !params[:image_url]
      @url = "http://a4.sphotos.ak.fbcdn.net/hphotos-ak-snc7/71749_446201531986_694716986_5762971_5788064_n.jpg"
      @colors = ['#DFE2E7', '#9D8C73', '#B0A48E', '#8A765C', '#73604B', '#CABEA7', '#604C36', '#3B2919']
    else
      @url = params[:image_url]
      if @url == "http://farm3.staticflickr.com/2727/4394310695_3792c55ff8.jpg"
        @colors = ['#FCF8FA', '#DBAABD', '#EB6D91', '#EA98AA', '#553F45', '#C5556B', '#A47487', '#BD827B']
      elsif @url == "http://farm2.staticflickr.com/1294/4681600020_5ef3116077.jpg"
        @colors = ['#A0A1A3','#BEBFC0', '#8B7B70', '#66748A', '#353332', '#788697', '#5F5F64', '#D6D5D4']
      elsif @url == "http://farm6.staticflickr.com/5064/5896103449_fa2c7a168d.jpg"
        @colors = ['#12191F','#555347', '#A7673F', '#C99B57', '#ECE0DD', '#A7A894', '#D4BEA1', '#6F8F85']
      else
        extr = Prizm::Extractor.new(@url)
        @colors = extr.get_colors(8, false).map { |p| extr.to_hex(p) }
        extr = nil
      end
    end
    set_style
  end
  
  def customize
    @colors = params[:colors]
    set_style
  end
  
  private
  def set_style
    variables = %{
// Variables.less
// Variables to customize the look and feel of Bootstrap
// -----------------------------------------------------

// GLOBAL VALUES
// --------------------------------------------------

// Links
@linkColor:             #{@colors[7]};
@linkColorHover:        darken(@linkColor, 15%);

// Grays
@black:                 #{@colors[6]};
@grayDarker:            #{@colors[5]};
@grayDark:              #{@colors[4]};
@gray:                  #{@colors[3]};
@grayLight:             #{@colors[2]};
@grayLighter:           #{@colors[1]};
@white:                 #{@colors[0]};

// Accent colors
@blue:                  #049cdb;
@blueDark:              #0064cd;
@green:                 #46a546;
@red:                   #9d261d;
@yellow:                #ffc40d;
@orange:                #f89406;
@pink:                  #c3325f;
@purple:                #7a43b6;

// Typography
@baseFontSize:          13px;
@baseFontFamily:        "Helvetica Neue", Helvetica, Arial, sans-serif;
@baseLineHeight:        18px;
@textColor:             @grayDark;

// Buttons
@primaryButtonBackground:    @linkColor;

// COMPONENT VARIABLES
// --------------------------------------------------

// Z-index master list
// Used for a bird's eye view of components dependent on the z-axis
// Try to avoid customizing these :)
@zindexDropdown:        1000;
@zindexPopover:         1010;
@zindexTooltip:         1020;
@zindexFixedNavbar:     1030;
@zindexModalBackdrop:   1040;
@zindexModal:           1050;

// Input placeholder text color
@placeholderText:       @grayLight;

// Navbar
@navbarHeight:                    40px;
@navbarBackground:                @grayDarker;
@navbarBackgroundHighlight:       @grayDark;

@navbarText:                      @grayLight;
@navbarLinkColor:                 @grayLight;
@navbarLinkColorHover:            @white;

// Form states and alerts
@warningText:             #c09853;
@warningBackground:       #fcf8e3;
@warningBorder:           darken(spin(@warningBackground, -10), 3%);

@errorText:               #b94a48;
@errorBackground:         #f2dede;
@errorBorder:             darken(spin(@errorBackground, -10), 3%);

@successText:             #468847;
@successBackground:       #dff0d8;
@successBorder:           darken(spin(@successBackground, -10), 5%);

@infoText:                #3a87ad;
@infoBackground:          #d9edf7;
@infoBorder:              darken(spin(@infoBackground, -10), 7%);

// GRID
// --------------------------------------------------

// Default 940px grid
@gridColumns:             12;
@gridColumnWidth:         60px;
@gridGutterWidth:         20px;
@gridRowWidth:            (@gridColumns * @gridColumnWidth) + (@gridGutterWidth * (@gridColumns - 1));

// Fluid grid
@fluidGridColumnWidth:    6.382978723%;
@fluidGridGutterWidth:    2.127659574%;
      
    }
    @less = variables + Lavish::Application::BOOTSTRAP
    @css = Lavish::Application::PARSER.parse(@less).to_css
    variables = nil
  end
end