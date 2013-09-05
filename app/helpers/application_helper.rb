module ApplicationHelper
  def navbar_active?(name)
    if params[:action] == name
      "active"
    else
      ""
    end
  end
end
