staff_members = StaffMember.all

256.times do |n|
  m = staff_members.sample
  # ↑の「sample」が、「ランダムに引き出す」という意味に。
  e = m.events.build
  if m.active?
      if n.even?
        e.type = "logged_in"
      else
        e.type = "logged_out"
      end
  else
    e.type = "rejected"
  end
  e.occurred_at = (256 - 1).hours.ago
  e.save!
end
