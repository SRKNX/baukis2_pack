class Staff::Base < ApplicationController
  # Staffに属するコントローラーで使い回したいメソッドがある場合、あるいは
  # Staffに属するコントローラー全てに適用したいメソッドがある場合、
  # base.rbを作るのだ。
  # 使いたい場合、使うコントローラーのclass~の表記の下に
  # class Staff::TopController < Staff::Base
  # と表記する必要があるぞ。

  before_action :authorize
  # これで、skip_before_actionで除外したコントローラー下にあるものを除いて
  # 全てのコントローラー下にあるメソッドの使用前にこの処理
  # 「管理者としてログインしていない時にはログイン画面まで転送する」を挟ませられるのだ。

  before_action :check_timeout
  # 60秒後にログインが解ける仕組み。

  before_action :check_account
  # こちらは「アカウント停止」に設定したユーザーのログインを強制的に解除する設定だ。



  helper_method :current_staff_member
  # 以上のようにhepler_methodにここで定義したメソッドを書いておくと、
  # application_helper.rbに同じメソッドを定義するのと同じ効果がある。
  # その結果、erbファイルでもこのメソッドが使えるようになるのだ。

  private

  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
        # find_byで、idがsession[:staff_member_id]に等しい投稿(職員)を検出。
        # ||= は、「それ以外に値が無ければ、=で指定した値を代入する」という意味になる。
    end
  end

  def authorize
    unless current_staff_member
      flash.alert = "職員としてログインしてください。"
      redirect_to :staff_login
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :staff_root
    end
  end


  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      if session[:last_access_time] >= TIMEOUT.ago
        # .ago = 現在時刻からの経過時間
        session[:last_access_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :staff_login
      end

    end
  end

end
