# class Admin::TopController < ApplicationController
class Admin::TopController < Admin::Base
  skip_before_action :authorize
  # base.rbでbefore_actionとして定義した処理を適用させたくない場合はこの処理を。

  def index
    # render action: "index"
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end
