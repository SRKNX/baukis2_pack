class AddressPresenter < ModelPresenter
  # include HtmlBuilder

  # delegate :type, :address1, :address2,
  #   :company_name, :division_name, to: :object
  # ↑ 表示したい要素をここで設定していないため、
  # :prefectureと:cityが「undifined method」になってしまった。
  delegate :prefecture, :city, :address1, :address2,
    :company_name, :division_name, to: :object


  def postal_code
    if md = object.postal_code.match(/\A(\d{3})(\d{4})\z/)
      md[1] + "-" + md[2]
    else
      object.postal_code
    end
  end


end
