# class StaffMemberFormPresenter < FormPresenter
class AddressFormPresenter < FormPresenter
# ここはUserFormPresenterで使用する要素は使わないため
# 継承元は「FormPresenter」

  def postal_code_block(name, label_text, options)
    markup(:div, class:"input-block") do |m|
      # m << label(name, label_text,
      #   class: options[:required] ? "required" : nil)
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      m.span "7桁以上の数字で入力してください" , class: "notes"
      m << error_messages_for(name)
    end
  end




end
