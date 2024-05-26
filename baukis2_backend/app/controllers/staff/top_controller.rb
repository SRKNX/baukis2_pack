# class Staff::TopController < ApplicationController
# ↓のコードで、base.rbで定義されたメソッドが使えるようになるぞ。上はoffに。
class Staff::TopController < Staff::Base
    skip_before_action :authorize
    # base.rbでbefore_actionとして定義した処理を適用させたくない場合はこの処理を。

  def index

    if current_staff_member
      render action: "dashboard"

    else

      # raise
      # raise Forbidden
      # raise IpAddressRejected
      # raise ActiveRecord::RecordNotFound
      render action: "index"

    end

  end
end
