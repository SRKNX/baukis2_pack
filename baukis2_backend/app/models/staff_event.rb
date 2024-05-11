class StaffEvent < ApplicationRecord
  self.inheritance_column = nil
  # 上のキーで、ーー…(そのまま床に倒れた)

  belongs_to :member, class_name: "StaffMember", foeign_key: "staff_member_id"
  # ↑「staff_member」モデルを、「:member」という名前で参照できるようになるキー。
  alias_attribute :occurred_at, :created_at
end
