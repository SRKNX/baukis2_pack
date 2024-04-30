class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render "new"
    end
  end

  def create
    @form.Admin::LoginForm.new(params[:admin_login_form])
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
        flash.notice = "ログイン成功: ようこそ"
        redirect_to :staff_root
      end

    else
        flash.alert = "ログイン失敗:メールアドレス/パスワードをご確認ください。"
        render action: "new"
    end



  end


end
