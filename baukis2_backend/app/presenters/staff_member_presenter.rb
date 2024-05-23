# class ModelPresenter
class StaffMemberPresenter < ModelPresenter
# ModelPresenterから継承させる形で「staff_member」のモデルプレゼンターを作るのだ。

  delegate :family_name, :given_name, :family_name_kana,
   :given_name_kana, :suspended?, to: :object


# 職員の停止フラグのOn/Offを表現する記号を返す。
# On: BALLOT BOX WITH CHECK (U+2611)
# Off: BALLOT BOX (U+2610)
  def susupended_mark

    suspended? ? raw("&#x2611;") : raw("&#x2610;")

    # object.suspended? ?
    #   view_context.raw('&#x2611;') :
    #   view_context.raw('&#x2610;')
    #
    # m.suspended? ? raw("&#x2611;") : raw("&#x2610;")
    # を移してきたものなのだが、rawはそのまま書くとエラーになるため、
    # view_contextに繋ぐ形で利用している。
    # view_contextで全てのhelperメソッドに接続できるのだ。
    #
    # ただし、継承元のmodel_presenters.rbの先頭で
    #   delegate :raw, to: :view_context
    # と入力することでもっと楽できる。
    #
    #
    # m.suspended? ? raw("&#x2611;") : raw("&#x2610;")
    # をほぼそのまま持ってこれるのだ。
    #
    # # …以上のコードだと記述量が多いので、以下に変えてみる。


  end

  def full_name
    markup do |m|
      m.text family_name + " " + given_name
    end

  end

  def full_name_kana
    markup do |m|
      m.text family_name_kana + " " + given_name_kana
    end

  end


end
