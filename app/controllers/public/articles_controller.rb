class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
  
  def index
    @articles = Article.all
  end

  def show
     @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article.id)
      flash[:notice] = '投稿に成功しました'
    else
      flash.now[:alert] = '投稿内容を入力してください。'
      render "new"
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:notice] = '編集に成功しました'
    else
      render "edit"
    end
  end

  def destroy
  end
  
  private

  def article_params
    params.require(:article).permit(:status, :image, :text)
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end
  
end
