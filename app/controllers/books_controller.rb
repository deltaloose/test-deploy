class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		flash[:success] = 'Book was successfully create'
		redirect_to book_path(@book.id)
		else
	    @books = Book.all
	    render :index
		end
	end
	def index
		@book = Book.new
		@books = Book.all
	end
	def show
		@Book = Book.new
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@book_comment = BookComment.new
	end
	def edit
		@book = Book.find(params[:id])
	end
	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
		flash[:notice] = 'You have updated book successfully.'
      	redirect_to book_path(@book.id)
        else
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
#		unless current_user.books.find_by(id: params[:id])
		@book = Book.find(params[:id])
		unless @book.user.id == current_user.id
			redirect_to books_path
		end
	end
end
