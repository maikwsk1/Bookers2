class BooksController < ApplicationController


  def new
    @book = Book.new
  
  end
  
  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book.id) # クリエイトが成功したら books/:id へリダイレクト
    else
      render :new # クリエイトが失敗したら new ページを再表示
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
 end
 
 def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title,:body,:image)
  end
end