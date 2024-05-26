# class StaffMemberFormPresenter < FormPresenter
class CustomerFormPresenter < UserFormPresenter
# 似たフォームを作るときに使いまわせる「UserFormPresenter」ができたため、
# 親も「UserFormPresenter」に変更。
# かつての親「FormPresenter」は「UserFormPresenter」が
# 継承しているのでFormPresenter側の要素も使えるぞ。
# かつて存在した要素は「UserFormPresenter」を参照。
# 「UserFormPresenter」にないsuspended_check_boxだけが
# ここStaffMemberFormPresenterに残ることに。

  def gender_field_block
    markup(:div, class:"radio-button") do |m|
      # m << label(name, label_text,
      #   class: options[:required] ? "required" : nil)
      m << decorated_label(:gender, "性別")
      m << radio_button(:gender, "male")
      m << label(:gender_male, "男性")
      m << radio_button(:gender, "female")
      m << label(:gender_female, "女性")
    end
  end


end
