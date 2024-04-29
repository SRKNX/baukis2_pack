class Staff::TopController < ApplicationController
  def index
    # raise
    # raise Forbidden
    # raise IpAddressRejected
    # raise ActiveRecord::RecordNotFound
    render action: "index"
  end
end
