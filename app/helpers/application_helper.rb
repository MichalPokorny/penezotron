# encoding: UTF-8

module ApplicationHelper
	def icon_link(url, icon)
		link_to '', url, :class => "icon-#{icon} icon-large"
	end

	def menu_icon_link(title, url, icon)
		"<a href=\"#{url_for url}\"><i class=\"icon-#{icon}\"></i>#{title}</a>".html_safe # TODO: XSS
	end

	def money(amount)
		amount.to_s + " Kč"
	end

	def datetime(datetime)
		l datetime, :format => :long
	end
end
