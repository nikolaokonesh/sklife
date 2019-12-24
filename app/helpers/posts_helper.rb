module PostsHelper
  def image_helper(post)
    image = post.body_post.embeds.includes(:blob).find(&:image?)
    return post_first_image(image) if image.present?
  end

  def post_first_image(image)
    html = <<-HTML
    <div class="h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-t-lg lg:rounded-t-none
                lg:rounded-l-lg text-center overflow-hidden"
          style="background-image:
                url('#{main_app.url_for(image.representation(resize_to_fill: [300, 300]))}');">
    </div>
    HTML

    html.html_safe
  end

  def blob_file_name_helper(blob)
    if caption = blob.try(:caption)
      caption
    else
      caption = blob.filename
    end
  end
end
