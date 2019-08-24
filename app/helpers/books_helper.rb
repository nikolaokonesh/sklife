module BooksHelper

  def bookanounce_class(type)
    "text-red-600" if type.blank?
  end

  def user_added_to_library? user, book
    if user_signed_in?
      user.libraries.where(user: user, book: book).any?
    end
  end
end
