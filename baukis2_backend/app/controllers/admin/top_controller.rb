# class Admin::TopController < ApplicationController
class Admin::TopController < Admin::Base
  def index
    # render action: "index"
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end
