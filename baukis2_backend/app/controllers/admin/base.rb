class Admin::Base < ApplicationController
  # Adminに属するコントローラーで使い回したいメソッドがある場合、あるいは
  # Adminに属するコントローラー全てに適用したいメソッドがある場合、
  # base.rbを作るのだ。
  # 使いたい場合、使うコントローラーのclass~の表記の下に
  # class Admin::TopController < Admin::Base
  # と表記する必要があるぞ。

  private

  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
        # find_byで、idがsession[:administrator_id]に等しい投稿(職員)を検出。
        # ||= は、「それ以外に値が無ければ、=で指定した値を代入する」という意味になる。
    end
  end

  helper_method :current_administrator
  # 以上のようにhepler_methodにここで定義したメソッドを書いておくと、
  # application_helper.rbに同じメソッドを定義するのと同じ効果がある。
  # その結果、erbファイルでもこのメソッドが使えるようになるのだ。
end
