class ApplicationController < ActionController::Base
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError
  end
  class IpAddressRejected < ActionController::ActionControllerError
  end


  # ↓ concerns/error_handlers.rbへ移転しました
  #
  # rescue_from StandardError, with: :rescue500
  # # ↑上のコードは以下コードの親にあたるらしく、ここを以下コードの後にすると動かなくなるようです。
  # rescue_from Forbidden, with: :rescue403
  # rescue_from IpAddressRejected, with: :rescue403
  # rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  #
  # ↑ concerns/error_handlers.rbへ移転しました

  include ErrorHandlers if Rails.env.production?
  # include ErrorHandlers
  # ↑上のコードを使用することで、concernで使用しているファイルのmodule要素が使えるようになるぞ。
  # オリジナルのエラー画面がでたほうが開発を進めやすいため、productionに限定している。

  # ↓ concerns/error_handlers.rbへ移転しました
  #
  # private
  #
  # def rescue403(e)
  #   @exception = e
  #   render "errors/forbidden", status: 500
  # end
  #
  # def rescue404(e)
  #   render "errors/not_found", status: 404
  # end
  #
  # def rescue500(e)
  #   render "errors/internal_server_error", status: 500
  # end
  #
  # ↑ concerns/error_handlers.rbへ移転しました


  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      "customer"
    end
  end


end
