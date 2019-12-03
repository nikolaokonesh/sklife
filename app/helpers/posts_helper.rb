module PostsHelper

  def image_helper(post)
    image = embedd(post)
    if image.present?
      gf = content_tag :div, '',
        class: "h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-t-lg lg:rounded-t-none lg:rounded-l-lg text-center overflow-hidden",
        style: "background-image: url('#{main_app.url_for(image.representation(resize_to_fill: [ 300, 300 ]))}');"
      return gf
    else
      nil
    end
  end

  def embedd(post)
    @imh = post.body_post.embeds.includes(:blob).find{|embeds| embeds.image?}
    return @imh
  end

end
