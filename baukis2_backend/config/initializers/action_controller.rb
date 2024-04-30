Rails.application.configure do
  config.action_controller.permit_all_parameters = true
  # セキュリティの関係上、上の設定は基本的に使わない。
  # フォームの説明を単純化するため一時的に有効に。
end
