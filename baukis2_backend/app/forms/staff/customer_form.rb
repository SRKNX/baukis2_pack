class Staff::CustomerForm
# class Staff::Baseではなく、ActiveModel::Modelを継承するのがポイント。
# これで、form_withのmodelオプションに指定できる。
  include ActiveModel::Model

  attr_accessor :customer
  # 上のattr_accessorで指定している属性はそのままフォームのフィールドになる。

  delegate :persisted?, to: :customer
  # DB上に保存されているかどうかを判別するもの。
  # 私の理解が正しければだが、
  # テキストによれば、「||=」使用時だろうと
  # 「DB上に保存されているか」の判別には「persisted?」を用いているらしく
  # わざわざここで呼び出しておかないと、判別が効かなくなるらしい。

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new(gender:"male")
    # genderに、初期値としてmaleを定めているようだ。
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
  end



  def assign_attributes(params={})

    @params = params

    customer.assign_attributes(custom_params)
    customer.assign_attributes(home_address_params)
    customer.assign_attributes(work_address_params)

  end


  def save
    ActiveRecord::Base.transaction do
      customer.save!
      customer.home_address.save!
      customer.work_address.save!

    end
  end



  private


  def custom_params
    params.require(:custom).permit(:email, :password,
        :family_name, :given_name, :family_name_kana,
        :given_name_kana, :gender, :birthday
     )
  end

  def home_address_params
    params.require(:home_address).permit(:postal_code, :prefecture,
        :city, :address1, :address2
     )
  end

  def work_address_params
    params.require(:work_address).permit(:postal_code, :prefecture,
        :city, :address1, :address2, :company_name, :division_name
     )
  end



end
