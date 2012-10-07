module ApplicationHelper
  def icon_link(url, icon)
    link_to '', url, :class => "icon-#{icon} icon-large"
  end
end
