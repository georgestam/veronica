class ArticlesController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @articles = Article.all
    policy_scope(Article)
  end

  def show
    @article = Article.friendly.find(params[:id])
    authorize @article
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :locale, :photo, :photo_cache)
  end
    
end
