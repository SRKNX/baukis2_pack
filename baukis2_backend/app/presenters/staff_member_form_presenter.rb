# class StaffMemberFormPresenter < FormPresenter
class StaffMemberFormPresenter < UserFormPresenter
# 似たフォームを作るときに使いまわせる「UserFormPresenter」ができたため、
# 親も「UserFormPresenter」に変更。
# かつての親「FormPresenter」は「UserFormPresenter」が
# 継承しているのでFormPresenter側の要素も使えるぞ。
# かつて存在した要素は「UserFormPresenter」を参照。
# 「UserFormPresenter」にないsuspended_check_boxだけが
# ここStaffMemberFormPresenterに残ることに。

  def suspended_check_box

    markup(:div, class:"check-boxes") do |m|
      m << check_box(:suspended)
      m << label(:suspended, "アカウント停止")
    end

  end


end
