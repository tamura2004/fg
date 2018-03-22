class SessionsController < ApplicationController
  before_action :set_zone

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
      redirect_to zone_contents_path(@zone)
    else
      flash.now.alert = "ユーザー名またはパスワードが違います"
      render action: "new"
    end
  end

  # ログアウト
  def destroy
    session.delete(:user_id)
    flash.notice = "ログアウトしました"
    redirect_to zone_login_path(@zone)
  end

  private
    def set_zone
      @zone = Zone.find(params[:zone_id])
    end

    def login_form_params
      params.require(:login_form).permit(:uid, :password)
    end

end
