class BooksController < ApplicationController
before_action :authenticate_user!


  def new
    @book = Book.new
    @newbook = Book.new
  end
  
  # 投稿データの保存
def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id

  if @book.save
      flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id) # Redirect to the book's show page if successful
  else
    # Render the index page with the error messages
    @books = Book.all
    @user = User.first
    
    render :index
  end
end

  def index
    @book = Book.new 
    @books = Book.all  
    @user = User.first 
  end

 def show
    @book = Book.find_by(id: params[:id])

    unless @book
      redirect_to books_path, alert: 'Book not found'
      return
    end
    
     @newbook = Book.new 
     @user = @book.user
     @books = @user.books
 end
 
 def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end
  
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end
  
  def edit
  @book = Book.find(params[:id])
  if current_user != @book.user
    flash[:alert] = "You don't have permission to edit this post."
 redirect_to books_path(@user)
  end
end
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end