# -*- encoding : utf-8 -*-
class CustomRenderer < Redcarpet::Render::HTML
  def emphasis(text)
    "\<i>#{text}\</i>"
  end

  def double_emphasis(text)
    "\<b>#{text}\</b>"
  end
end
