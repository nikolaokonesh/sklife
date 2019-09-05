module BooksHelper

  def bookanounce_class(type)
    "text-red-600" if type.blank?
  end

  def user_added_to_library? user, book
    if user_signed_in?
      user.libraries.where(user: user, book: book).any?
    end
  end

  private

    def views_pages_helper(book, user)
      @bp = book.pages
      uv = user.views.where(page: [@bp]).each do |view|
        view.id
      end
      uv.to_a.size
    end

    def user_view_page(user, page)
      if user.views.where(page: page).any?
        icon('fas', 'check', title: 'Прочтено', class: 'text-xs')
      end
    end

end
