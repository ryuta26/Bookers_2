class BooksController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
        if book.save
        	flash[:success] = "Book was successfully created."
        	redirect_to book_path(book)
	    else
	    	flash[:danger] = 'error'
			redirect_to books_path
		end

	end

	def index
		@books = Book.all
		@users = User.all
		@user = current_user
        @book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@new_book = Book.new
	end

	def edit
	    @book = Book.find(params[:id])
	    @user = @book.user
	end

	def update
		@book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:success] = "Book was successfully updated."
       redirect_to book_path(@book)
    else
    	flash[:danger] = 'error'
      render :edit
    end
	end

	def destroy
		@book = Book.find(params[:id])
	  	@book.destroy
	  	redirect_to books_path
	end

	private
    def book_params
      params.require(:book).permit(:title, :body)
    end
    def correct_user
  @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to books_path
    end
end
end
