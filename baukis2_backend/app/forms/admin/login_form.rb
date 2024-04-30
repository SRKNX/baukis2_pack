class Admin::LoginForm
# class Staff::Baseではなく、ActiveModel::Modelを継承するのがポイント。
# これで、form_withのmodelオプションに指定できる。
  include ActiveModel::Model

  attr_accessor :email, :password
  # 上のattr_accessorで指定している属性はそのままフォームのフィールドになる。
end
