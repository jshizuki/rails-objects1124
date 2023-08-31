# Q1. nameとemailのパラメータが送られてきた時、その２つの値でUserレコードに新規作成するメソッドを作成してください
# params = { user: {name: 'みんせつ太郎', email: 'test@msetsu.com'} }
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email
    )
  end
end
