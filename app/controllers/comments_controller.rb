class CommentsController < ApplicationController
    before_action :set_article

    def create
        @comment = @article.comments.create(comment_params.to_h.merge!({ user_id: current_user.id }))
    end

    private
    
    def comment_params
        params.require(:comment).permit(:body)
    end

    def set_article
        @article = Article.find(params[:article_id])
    end
end
