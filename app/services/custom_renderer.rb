# render italics bolder and link for markdown
class CustomRenderer < Redcarpet::Render::HTML

	def preprocess(text)

		wrap_mentions(text)

	end

	def wrap_mentions(text)

		text.gsub!  /!!!\s*(.+)$/ do

			"#{$1}<b>#{$2}</b>"

		end

		text

	end

	def double_emphasis(text)

		"\<b>#{text}\</b>"

	end

	def emphasis(text)

		"\<i>#{text}\</i>"

	end

end