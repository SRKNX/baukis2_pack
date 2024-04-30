Rails.application.configure do
  config.action_view.form_with_generates_remote_forms = false
  # 「リモートフォーム」たるものを作るための設定。
  # おそらくXvueにはtrueが必須と思われるが、今回は使わないためoffに。
end
