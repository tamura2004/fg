class SessionsController < ApplicationController

  #ログイン画面
  def new
    @form = LoginForm.new
    render action: "new"
  end

  # ログイン
  def create
    @form = LoginForm.new(login_form_params)
    if @form.uid.present?
      user = User.find_by(uid: @form.uid)
    end
    if Authenticator.new(user).authenticate(@form.password)
      session[:user_id] = user.id
      flash.notice = "ログインしました"
      redirect_to :root
    else
      flash.now.alert = "ユーザー名またはパスワードが違います"
      render action: "new"
    end
  end

  # ログアウト
  def destroy
    session.delete(:user_id)
    flash.notice = "ログアウトしました"
    redirect_to :root
  end

  private

    def login_form_params
      params.require(:login_form).permit(:uid, :password)
    end

end
