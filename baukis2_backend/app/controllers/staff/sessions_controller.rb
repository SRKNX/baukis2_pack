class Staff::SessionsController < Staff::Base

  skip_before_action :authorize
  # base.rbでbefore_actionとして定義した処理を適用させたくない場合はこの処理を。

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
    @form = Staff::LoginForm.new(login_form_params)
    # @form = Staff::LoginForm.new(params[:staff_login_form])
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
        staff_member.events.create!(type: "rejected");
        # ↑ モデル(staff_events)に、「self.inheritance_column = nil」を加えて
        # belongs_to :member, class_name: "StaffMember"で
        # 関係を持たせたことでコントローラー上で直接値を入れることができる。
        # 「staff_events」ではなく「events」となっているのも、class_name設定で
        # 詳細なクラスを設定しているためだ

        flash.alert = "ログイン失敗:アカウント利用停止中"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        session[:last_access_time] = Time.current
        # ↑ログイン時の時刻を記録。

        staff_member.events.create!(type: "logged_in");

        flash.notice = "ログイン成功: ようこそ"
        redirect_to :staff_root
      end

    else
      flash.alert = "ログイン失敗:メールアドレス/パスワードをご確認ください。"
      render action: "new"
    end
  end

  def destroy
    if current_staff_member
      current_staff_member.events.create!(type: "logged_out");
    end
    # if関数で囲っているのは、ログアウトがされた状態でdestroyメソッドが来た時のため。
    # すぐ下で「ログアウトをする」処理があるため、
    #「記録をする」機能はまだセッションが生きている一番上に。
    session.delete(:staff_member_id)
    flash.notice = "ログアウト: またのご利用をお待ちしております"
    redirect_to :staff_root
  end

  private

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end


end
