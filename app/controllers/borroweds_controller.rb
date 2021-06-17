class BorrowedsController < ApplicationController


  before_action :find_book
  before_action :find_borrowed, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @borrowed = Borrowed.new
  end

  

  def create

    @borrowed = Borrowed.new(borrowed_params)
    
      @borrowed.book_id = @book.id
      @borrowed.user_id = current_user.id

      if @borrowed.save
        redirect_to book_path(@book)
      else
        render 'new'
      end
      
  end

  def edit
  end

  def update
    if @borrowed.update(borrowed_params)

      if @borrowed.borrowed_days > @borrowed.borrowed_date
        redirect_to book_path(@book)
      end

    else
      render 'edit'
    end
  end

  def destroy
    @borrowed.destroy
    redirect_to book_path(@book)
  end

  private

    def borrowed_params
      params.require(:borrowed).permit(:borrowed_date, :borrowed_days)

    end

    def find_book
      @book = Book.find(params[:book_id])
    end

    def find_borrowed
      @borrowed = Borrowed.find(params[:id])
    end

end
