class ArticlesController < ApplicationController
    include Paginable

    before_action :set_article, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, except: %i[ show index ]
    before_action :set_categories, only: %i[ new create edit update ]

  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category]}[0] if (params[:category]).present?

    @highlights = Article.joins([:category, :user])
                         .includes([:category, :user])
                         .filter_by_category(category)
                         .filter_by_archive(params[:month_year])
                         .order(created_at: :desc).first(3)
                         
    highlights_ids = @highlights.pluck(:id)

    @articles = Article.joins([:category, :user])
                       .includes([:category, :user])
                       .order(created_at: :desc)
                       .filter_by_category(category)
                       .filter_by_archive(params[:month_year])
                       .where.not(id: highlights_ids)
                       .page(current_page).per(10)
    
    @archives = Article.group_by_month(:created_at, format: '%B %Y').count

end

  def show; end

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
        authorize @article
    end

    def set_categories
        @categories  = Category.sorted
    end
end
