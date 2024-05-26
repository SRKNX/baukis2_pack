class CustomerPresenter < ModelPresenter
  # include HtmlBuilder
  delegate :email, to: :object


  def full_name
    object.family_name + " " + object.given_name
  end

  def full_name_kana
    object.family_name_kana + " " + object.given_name_kana
  end

  def birthday
    return "" if object.birthday.blank?
    object.birthday.strftime("%Y/%m/%d")
  end

  def gender
    case object.gender
    when "male"
      "男性"
    when "female"
      "女性"
    else
      ""
    end

    # if object.gender = "male"
    #   "男性"
    # elsif object.gender = "female"
    #   "女性"
    # else
    #   ""
    # end
    # ↑ えぇ…？
    # if文でなんでダメなの…?

  end

  def created_at
    object.created_at.try(:strftime, "%Y/%m/%d %H:%M:%S")
  end

  def updated_at
    object.created_at.try(:strftime, "%Y/%m/%d %H:%M:%S")
  end



end
