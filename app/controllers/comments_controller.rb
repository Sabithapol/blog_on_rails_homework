class CommentsController < ApplicationController
    def create 
        # POST PATH = /questions/:question_id/answers
        @post = Post.find params[:post_id]
        # @question = { id: 1, title: 'your question title', body: 'your question body', ...}
        @comment = Comment.new comment_params 
        # @answer = { body: 'your answer' }
        @comment.post = @post # @answer = { body: 'your answer', question_id: 1 }
        @comment.user = current_user
        if @comment.save
            # AnswerMailer.new_answer(@answer).deliver_now
            redirect_to post_path(@post)
        else 
            # For the list of answers
            @comment = @post.comment.order(created_at: :desc)
            render 'post/show'
        end
    end

    def destroy
        # DELETE PATH = /questions/:question_id/answers/:id
        @comment = Comment.find params[:id]
        if can?(:crud, @comment) 
            @comment.destroy 
            redirect_to post_path(@comment.post)
        else
            # head will send an empty HTTP response with
            # a particular response code, in this case
            # unauthorized 401
            # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
            head :unauthorized
            # redirect_to root_path, alert: 'Not Authorized'
        end
    end

    private

    def comment_params 
        params.require(:comment).permit(:body)
    end
end
