module PostsHelper

  def image_helper(post)
    image = post.body_post.embeds.find{|embeds| embeds.image?}
    if image.present?
      content_tag :div, '',
        class: "h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-t-lg lg:rounded-t-none lg:rounded-l-lg text-center overflow-hidden",
        style: "background-image: url('#{main_app.url_for(image.representation(resize_to_fill: [ 300, 300 ]))}');"
    end
  end

end
