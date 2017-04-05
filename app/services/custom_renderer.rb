# -*- encoding : utf-8 -*-
# render italics bolder and link for markdown
class CustomRenderer < Redcarpet::Render::HTML

	def emphasis(text)

		"\<i>#{text}\</i>"

	end

	def double_emphasis(text)

		"\<b>#{text}\</b>"

	end

end