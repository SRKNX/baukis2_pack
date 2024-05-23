class StaffMemberFormPresenter < FormPresenter

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
      # 「decolated_label」で書き換えられる。

      m << decolated_label(name1, label_text, options={})
      m << text_field(name1, options)
      m << text_field(name2, options)
      m << effor_messages_for(name1)
      m << effor_messages_for(name2)
    end
  end



  def suspended_check_box

    markup(:div, class:"check-boxes") do |m|
      m << check_box(:suspended)
      m << label(:suspended, "アカウント停止")
    end

  end


end
