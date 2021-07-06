class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン成功した場合
      session[:user_id] = user.id
      flash[:notice] = "ログインに成功しました。"
      # 管理者画面とユーザー画面の分岐
      if user.admin?
        redirect_to admin_users_path(user.id)  #管理者画面
      else
        redirect_to user_path(user.id)    #ユーザー画面
      end
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました。'
    redirect_to new_session_path
  end
end
