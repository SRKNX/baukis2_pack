class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
      # ログインがすでにある場合、職員トップページへ飛ぶ仕組み。
    else
      @form = Staff::LoginForm.new
      # ↑はcurrent_staff_memberを使用するため。
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member =
        StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    # if staff_member
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)

    # app/services/staff/authenticator.rb
    # 以上ファイルに存在する「サービスオブジェクト」のクラスと、その中のメソッドを使って
    # ユーザー認証を行っているぞ。
    # 自分で設定を作るので自由な編集が可能だ。多分。

      if staff_member.suspended?
        flash.alert = "ログイン失敗:アカウント利用停止中"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログイン成功: ようこそ"
        redirect_to :staff_root
      end
      
    else
      flash.alert = "ログイン失敗:メールアドレス/パスワードをご確認ください。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "ログアウト: またのご利用をお待ちしております"
    redirect_to :staff_root
  end


end
