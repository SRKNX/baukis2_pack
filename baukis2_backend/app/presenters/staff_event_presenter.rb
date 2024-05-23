class StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_row
    markup(:tr) do |m|
      unless view_context.instance_variable_get(:@staff_member)

        m.td do
          # m << link_to(event.member.family_name + " " + event.member.given_name,
          #   [:admin, event.member, :staff_events])
          #
          # ↑ 値は
          # unless view_context.instance_variable_get(:@staff_member)
          # が取得するため「event.」は必要なし。

          m << link_to(member.family_name + " " + member.given_name,
            [:admin, member, :staff_events])
        end
      end
      m.td description
      m.td(:class => "date") do
        m.text occurred_at.strftime("%Y/%m/%d %H:%M:%S")
      end
    end
  end
end
