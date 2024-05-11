class Admin::StaffMembersController < Admin::Base
  # before_action :authorize
  # 設定しておくと全てのメソッドで
  # 実行する前に指定のメソッドを行ってくれる。
  # 応用することで、「ログインがあるかどうか確認する」メソッドを挟ませることができるのだ。
  #
  # base.rbでこれとメソッドを設定することで全てのコントローラー内メソッドで適用が効くぞ。
  # ただし、適用させたくない箇所では都度skip_before_actionを使う必要がある。

  def index
    @staff_members = StaffMember.page(params[:page]).order(:family_name_kana, :given_name_kana)
    # staff_memberのレコードを全取得し、姓・名のふりがな順で並べている。
    # ここからブラウザに表示するレコードを参照するのだろう。

    # @staff_members = @staff_members.page(params[:page])


  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [:edit, :admin, staff_member]
  end

  def new
    @staff_member = StaffMember.new
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    # @staff_member = StaffMember.new(params[:staff_member])
    if @staff_member.save
      flash.notice = "職員データ/アカウント新規追加"
      redirect_to :admin_staff_members
    else
      render action:"new"
    end

  end

  def update
    @staff_member = StaffMember.find(params[:id])
    @staff_member.assign_attributes(staff_member_params)
    # @staff_member.assign_attributes(params[:staff_member])

    if @staff_member.save
      flash.notice = "職員データ/アカウント更新"
      redirect_to :admin_staff_members
    else
      render action:"new"
    end

  end

  def destroy
    @staff_member = StaffMember.find(params[:id])
    @staff_member.destroy!
    flash.notice = "職員データ/アカウント 削除"
    redirect_to :admin_staff_members

  end


  private

  # def authorize
  #   unless current_administrator
  #     flash.alert = "管理者としてログインしてください。"
  #     redirect_to :admin_login
  #   end
  #
  # end
  # ↑ base.rbに移転。

  def staff_member_params
    # params.require(:sxtaff_member).permit(:email, :password, :family_name, :given_name, :family_name_kana, :given_name_kana, :start_date, :end_date, :suspended)
    # ↑不正なパラメータを送信しようとした時ようのエラー「400 bad request」を意図的に発生させるためのコード。
    params.require(:staff_member).permit(:email, :password, :family_name, :given_name, :family_name_kana, :given_name_kana, :start_date, :end_date, :suspended)
    # params.require(:staff_member).permit(:email, :password, :family_name,  :family_name_kana, :given_name_kana, :start_date, :end_date, :suspended)
    # ↑premitの値から何か抜いた時、変更を効かなくできるのだ。
  end

end
