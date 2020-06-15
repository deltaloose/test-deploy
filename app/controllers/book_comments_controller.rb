class BookCommentsController < ApplicationController
	before_action :correct_user, only: [:destroy]
	def create
		book = Book.find(params[:book_id])
		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = book.id
		@comment.save
		if @comment.save
			flash[:ok] = "OK, comment"
			redirect_to book_path(book.id)
		else
			flash[:denger] = "Failured comment"
			redirect_back(fallback_location: book_url(book.id))
		end
	end
	def destroy
		@book = Book.find(params[:book_id])
		@book_comment = @book.book_comments.find(params[:id])
		@book_comment.destroy
		redirect_to book_path(@book.id)
	end
	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
	def correct_user
    @book_comment = current_user.book_comments.find_by(id: params[:id])
	    unless @book_comment
	      redirect_to root_url
	    end
    end
end
