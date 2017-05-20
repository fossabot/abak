module ApplicationHelper
  def build_breadcrumb(category)
    result = []
    category.ancestors.each do |ancestor|
      result << content_tag(:li, class: 'breadcrumb-item') do
        link_to(ancestor.name, ancestor)
      end
    end
    result << content_tag(:li, category.name, class: 'breadcrumb-item active')
    result.join('').html_safe
  end

  def markdown(content)
    renderer = CustomRenderer.new(hard_wrap: true, filter_html: true)

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
