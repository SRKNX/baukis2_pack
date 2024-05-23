class FormPresenter

  include HtmlBuilder

  attr_reader :form_builder, :view_context

  delegate :label, :text_field, :date_field,
    :password_field, :check_box, :radio_button,
    :text_area, :object, to: :form_builder
    # 以上のフォームの要素を「form_builder」で呼び出せるようになった。

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    # objectはモデルとして作ったDBの値
    @view_context = view_context
    # view_contextはrailsで使用する関数を表してるらしい。
  end

  # 以下、どのフォームでも使いそうな値をここでHtmlBuilder式に作ってみる。

  def notes
    markup(:div, class:"notes") do |m|
      m.span "*", class:"mark"
      m.text "印のついた項目は必須項目です"
    end
  end

  def text_field_block(name, label_text, options={})
    markup(:div, class:"input-block") do |m|
      # m << label(name, label_text,
      #   class: options[:required] ? "required" : nil)
      # ↑ 以蔵の表記は繰り返し出てくるため、メソッドとして使いまわせるようにする。
      # decolated_labelという名前がついた。
      m << decolated_label(name, label_text, options={})
      m << text_field(name, options)
      m << effor_messages_for(name)
    end
  end

  def password_field_block(name, label_text, options={})
    markup(:div, class:"input-block") do |m|
      # m << label(name, label_text,
      #   class: options[:required] ? "required" : nil)
      m << decolated_label(name, label_text, options={})
      m << password_field(name, options)
      # 値無効時に、フォームにエラーが表示されるようになる。
      m << effor_messages_for(name)
    end
  end

  def date_field_block(name, label_text, options={})
    markup(:div, class:"input-block") do |m|
      # m << label(name, label_text,
      #   class: options[:required] ? "required" : nil)
      m << decolated_label(name, label_text, options={})
      m << date_field(name, options)
      m << effor_messages_for(name)
    end
  end


  def effor_messages_for(name)
    # エラーメッセージは、localeファイルを作って日本語になるよう調節。
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: "error-message") do |m|
          m.text message
        end
      end
    end


  end




  private

  def decolated_label(name, label_text, options={})
    label(name, label_text, class: options[:required] ? "required" : nil)
  end

end
