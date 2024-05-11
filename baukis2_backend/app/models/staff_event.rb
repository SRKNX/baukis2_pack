class StaffEvent < ApplicationRecord
  self.inheritance_column = nil
  # 上のキーで、ーー…(そのまま床に倒れた)

  belongs_to :member, class_name: "StaffMember", foreign_key: "staff_member_id"
  # ↑「staff_member」モデルを、「:member」という名前で参照できるようになるキー。
  alias_attribute :occurred_at, :created_at


  DESCRIPTION = {
      logged_in: "ログイン",
      logged_out: "ログアウト",
      rejected: "ログイン拒否"
  }

  def description
    DESCRIPTION[type.to_sym]
    # to_symは、「シンボルに変換」するやつ。
  end


end
