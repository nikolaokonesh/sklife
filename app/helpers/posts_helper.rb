module PostsHelper
  def image_helper(post)
    image = post.body_post.embeds.find(&:image?)
    return post_first_image(image) if image.present?
  end

  def post_first_image(image)
    html = <<-HTML
    <div class="h-48 lg:h-auto lg:w-48 lg:mr-3 flex-none bg-cover
                lg:rounded-lg text-center overflow-hidden"
          style="background-image:
                url('#{main_app.url_for(image.representation(resize_to_fill: [300, 300]))}');">
    </div>
    HTML

    html.html_safe
  end
end
