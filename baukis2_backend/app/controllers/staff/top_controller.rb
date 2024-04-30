# class Staff::TopController < ApplicationController
# ↓のコードで、base.rbで定義されたメソッドが使えるようになるぞ。上はoffに。
class Staff::TopController < Staff::Base


  def index
    # raise
    # raise Forbidden
    # raise IpAddressRejected
    # raise ActiveRecord::RecordNotFound
    render action: "index"
  end
end
