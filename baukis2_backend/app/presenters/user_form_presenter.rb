# class StaffMemberFormPresenter < FormPresenter
class UserFormPresenter < FormPresenter
# StaffMemberFormと同じような形式で入力するフォームが増えるので、
# 使いまわせる雛形として「UserFormPresenter」として運用する。
# かつて存在したStaffMemberFormPresenter、今から作るCustomerFormPresenterを
# この「UserFormPresenter」の小要素として持つ形になるぞ。

  def password_field_block(name, label_text, options={})
    if object.new_record?
      super(name, label_text, options)
    end
  end

  def full_name_block(name1, name2, label_text, options={})
    markup(:div, class:"input-block") do |m|
      # m << label(name1, label_text,
      #     class: options[:required] ? "required" : nil)
      # これもform_presenter.rbで書いた
      # 「decorated_label」で書き換えられる。

      m << decorated_label(name1, label_text, options={})
      m << text_field(name1, options)
      m << text_field(name2, options)
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end


end
