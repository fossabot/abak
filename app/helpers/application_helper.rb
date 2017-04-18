# -*- encoding : utf-8 -*-
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

  def markdown(content)

    # custom renderer class for replace symbols
    renderer = CustomRenderer.new(hard_wrap: true, filter_html: true)

    # options for save from smart script
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe

  end

end
