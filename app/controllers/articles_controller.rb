class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  authorize_resource
  respond_to :html

  def new
    respond_with(@article = Article.new)
  end

  def create
    respond_with(@article = Article.create(article_params.merge(user: current_user)))
  end

  def show
  end

  def update
    @article.update(article_params)
    respond_with(@article)
  end

  def edit
  end

  def destroy
    respond_with(@article.destroy)
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
