Rails.application.configure do
  config.exceptions_app = ->(env) do
    request = ActionDispatch::Request.new(env)

    # 500や403などの例外処理では捉えきれない
    # ルーディングエラーを補足する設定群。

    action =
      case request.path_info
      when "/404"; :not_found
      when "/422"; :unprocessable_entity
      else; :internal_server_error
      end

    ErrorsController.action(action).call(env)
  end
end
