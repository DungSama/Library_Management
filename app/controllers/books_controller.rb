 class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :show]

  def index

    if params[:category].blank?
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
    @books = Book.paginate(page: params[:page], per_page: 8).order("created_at DESC")

    if user_signed_in?
	    @book = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).where('borroweds.status LIKE ?', 'About_to_expire').uniq

    	@count = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).where('borroweds.status LIKE ?', 'Out_of_date').uniq.count

	    if @count > 0
	    	flash[:notice] = "You have #{@count} book Out of date "
	    end
  	end
  end

  def search
    @books = Book.where("title LIKE ?", "%" + params[:q] + "%")
  end

  def display

      if current_user.admin
		
        @borroweds = Borrowed.joins(:user).where("borroweds.user_id")

      	
      else
        @books = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).uniq

      end
  end

  def reading
  	  if current_user.admin
  		@borroweds = Borrowed.joins(:user).where("borroweds.user_id").where('status LIKE ?', 'Reading')
  		else
        @books = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).where('borroweds.status LIKE ?', 'Reading').uniq

      end
  end

  def paid
  	@borroweds = Borrowed.joins(:user).where("borroweds.user_id").where('status LIKE ?', 'Paid')
  end

  def about_to_expire
		
    @books = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).where('borroweds.status LIKE ?', 'about_to_expire').uniq
  end

	def out_of_date
		
  			@borroweds = Borrowed.joins(:user).where("borroweds.user_id = ?", current_user.id).where('status LIKE ?', 'Out_of_date')

  			@debt = @borroweds.map {|b| b.debt }.sum

 
        @books = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).where('borroweds.status LIKE ?', 'Out_of_date').uniq
     
  end

  def unread
  	@book  = Book.all
  	@book_borroweds = Book.joins(:borroweds).where("borroweds.user_id = ?", current_user.id).uniq
  	@books = (@book - @book_borroweds)
  	@books = Book.paginate(page: params[:page], per_page: 8).order("created_at DESC")
 
  end

  def show

    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
    
end

	def new
    @book = Book.new
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create

    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

    if @book.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update

    @book.category_id = params[:category_id]
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end

  end

  def destroy

    @book.destroy
    redirect_to root_path

  end

  private

    def book_params
      params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end

    def find_book
      @book = Book.find(params[:id])
    end

end