class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  # base.rbでbefore_actionとして定義した処理を適用させたくない場合はこの処理を。

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)


    # @form = Admin::LoginForm.new(params[:admin_login_form])
    # # @form.Admin::LoginForm.new(params[:admin_login_form])
    # # ↑ ほんとマジ気をつけろお前
    # # ただミスだけならviewのミスやservice/admin/authenticator.rbの未編集もあったし
    if @form.email.present?
      administrator =
        Administrator.find_by("LOWER(email) = ?", @form.email.downcase)
    end
      # if administrator
    if Admin::Authenticator.new(administrator).authenticate(@form.password)

      if administrator.suspended?
        flash.alert = "ログイン失敗:アカウント利用停止中"
        render action: "new"
      else
        session[:administrator_id] = administrator.id
        session[:admin_last_access_time] = Time.current
        flash.notice = "ログイン成功: ようこそ"
        redirect_to :admin_staff_members
      end

    else
        flash.alert = "ログイン失敗:メールアドレス/パスワードをご確認ください。"
        render action: "new"
    end

  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウト: またのご利用をお待ちしております"
    redirect_to :admin_root
  end




  private

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)

  end



end
