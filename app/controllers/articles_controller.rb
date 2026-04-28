class ArticlesController < ApplicationController
    before_action :set_article, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, except: %i[ show index ]
  def index
    @highlights = Article.order(created_at: :desc).first(3)
    current_page = (params[:page] || 1).to_i
    highlights_ids = @highlights.pluck(:id)

    @articles = Article.order(created_at: :desc)
                        .where.not(id: highlights_ids)
                        .page(current_page).per(2)
end

  def show
  end

  def new
      @article = current_user.articles.new
  end

  def create
      @article = current_user.articles.new(article_params)

      if @article.save
          redirect_to @article, notice: "Article was successfully created."
      else
          render :new, status: :unprocessable_entity
      end
  end

  def edit
  end

  def update
      if @article.update(article_params)
          redirect_to @article, notice: "Article was successfully updated."
      else
          render :edit, status: :unprocessable_entity
      end
  end

  def destroy
      @article.destroy
      redirect_to root_path, notice: "Article was successfully destroyed."
end

  private

  def article_params
      params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article
      @article = Article.find(params[:id])
  end
end
