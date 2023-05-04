class Admin::CommentsController < ApplicationController
  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    authorize [:admin]
    @user = User.find(params[:user_id])
    @comments = @user.articles.find(params[:article_id]).comments
  end

  private
    def user_not_authorized(exception)
      flash[:warning] = "You are not authorized to perform this action."

      redirect_to(request.referrer || root_path)
    end
end
