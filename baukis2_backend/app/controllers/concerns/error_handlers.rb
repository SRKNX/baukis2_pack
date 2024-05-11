module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    # ↑上のコードは以下コードの親にあたるらしく、ここを以下コードの後にすると動かなくなるようです。
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    # ↑ ApplicationControllerからは外へ出るため、「ApplicationController::」をつけている。
    # 使用する場所を書いておく必要があるのだ。
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from ActionController::ParameterMissing, with: :rescue400

  end


  private

  def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  def rescue404(e)
    render "errors/not_found", status: 404
  end

  def rescue500(e)
    render "errors/internal_server_error", status: 500
  end

  def rescue400(e)
    render "errors/bad_request", status: 400
  end

end
