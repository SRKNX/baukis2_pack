class Admin::Base < ApplicationController
  # Adminに属するコントローラーで使い回したいメソッドがある場合、あるいは
  # Adminに属するコントローラー全てに適用したいメソッドがある場合、
  # base.rbを作るのだ。
  # 使いたい場合、使うコントローラーのclass~の表記の下に
  # class Admin::TopController < Admin::Base
  # と表記する必要があるぞ。

  before_action :authorize
  # 元々staff_members_controller.rbで定義したbefore_actionとメソッドをここに移転。
  # これで、skip_before_actionで除外したコントローラー下にあるものを除いて
  # 全てのコントローラー下にあるメソッドの使用前にこの処理
  # 「管理者としてログインしていない時にはログイン画面まで転送する」を挟ませられるのだ。

  before_action :check_account
  # こちらは「アカウント停止」に設定したユーザーのログインを強制的に解除する設定だ。

  before_action :check_timeout
  # 60秒後にログインが解ける仕組み。
  # …これ思うんだけど注意力のなさとミスの多さってエンジニアやる上でもやっぱり致命的？

  helper_method :current_administrator
  # 以上のようにhepler_methodにここで定義したメソッドを書いておくと、
  # application_helper.rbに同じメソッドを定義するのと同じ効果がある。
  # その結果、erbファイルでもこのメソッドが使えるようになるのだ。


  private



  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
        # find_byで、idがsession[:administrator_id]に等しい投稿(職員)を検出。
        # ||= は、「それ以外に値が無ければ、=で指定した値を代入する」という意味になる。
    end
  end

  def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end
  # ↑ before_action :authorizeに同じく、staff_members_controller.rbより移転。

  def check_account
    if current_administrator && !current_administrator.active?
        # active? はmodel要素で設定しています
      session.delete(:administrator_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_administrator
      if session[:admin_last_access_time] >= TIMEOUT.ago
        # .ago = 現在時刻からの経過時間

        session[:admin_last_access_time] = Time.current
        # [:admin_last_access_time]は、
        #session_controller.rb内createメソッドのログイン成功時の処理でで定めています。
      else
        session.delete(:administrator_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      end

    end
  end


end
