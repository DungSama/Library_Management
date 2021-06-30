class Search < ApplicationRecord
	def books
  @books ||= find_books
end

private

def find_books

  books = Book.where("title like ?", "%#{keywords}%") if keywords.present?
  books = Book.where(category_id: category_id) if category_id.present?
  books = Book.where("author like ?", author) if author.present?
  books = Book.where("publish like?", publish) if publish.present?
  books
end
end
