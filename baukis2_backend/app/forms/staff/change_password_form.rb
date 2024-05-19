class Staff::ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :object, :current_password, :new_password,
    :new_password_confirmation
  validates :new_password, presence: true, confirmation: true
  #「new_password_confirmation」とあるものには単独でのバリデーションは不要。
  # confirmation:のようにオプションのように使うことで
  # 「_confirmation」の値と一致しない場合失敗する設定にできるぞ。

   validate do
     unless Staff::Authenticator.new(object).authenticate(current_password)
         # 「Staff::Authenticator」「authenticate」は
         # ログイン作成機能の時作ったやつ。
         # いうまでもなくここでも現在のパスワードが正しいかをチェックしてくれる。
       errors.add(:current_password, :wrong)
       # 多分4章「エラーメッセージ」でやったもの。
       # エラーを表示させる機能だ。
     end
   end
   # presenceやformなど標準装備もの以外でバリデーションを作りたいときは
   # validate do…方式もあり。

  def save
    if valid?
      object.password = new_password
      object.save!
    end
  end

end
