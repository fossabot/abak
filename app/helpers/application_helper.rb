module ApplicationHelper

	def build_breadcrumb(category)

		result = []

		category.ancestors.each do |ancestor|

			# add content to array with link on parent and ancestors
			result << content_tag(:li, class: "breadcrumb-item") do
				link_to(ancestor.name, ancestor)
			end

		end
		# add content to array current category
		result << content_tag(:li, category.name, class: "breadcrumb-item active")
		# return html
		result.join('').html_safe

	end

end
