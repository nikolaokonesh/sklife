module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg) }.join
    html = <<-HTML
    <div class="bg-red-400 border-red-300 text-red-800 p-2 mb-3">
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
