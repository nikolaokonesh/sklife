module BooksHelper
  def bookanounce_class(type)
    'text-red-600' if type.blank?
  end

  def user_added_to_library?(user, book)
    user.libraries.where(user: user, book: book).any? if user_signed_in?
  end

  private

  def views_pages_helper(book, user)
    @bp = book.pages
    uv = user.views.where(page: [@bp]).each(&:id)
    uv.to_a.size
  end

  def user_view_page(user, page)
    icon_svg('check.svg', class: 'svg-default') if user.views.where(page: page).any?
  end
end
