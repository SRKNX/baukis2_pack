class Staff::PasswordsController < Staff::Base
  def show
    redirect_to :edit_staff_password
  end

  def edit
    @change_password_form =
      Staff::ChangePasswordForm.new(object: :current_staff_member)
  end

  def update
    @change_password_form = Staff::ChangePasswordForm.new(staff_member_params)
    if @change_password_form.save
        # saveは
      flash.notice = "パスワードを変更しました"
      redirect_to :staff_account
    else
      flash.alert = "入力に誤りがあります"
      render "edit"
    end
  end

  private

  def staff_member_params
    params.require(:staff_change_password_form).permit(
        :current_password, :new_password, :new_password_confirmation
    )
  end

end
