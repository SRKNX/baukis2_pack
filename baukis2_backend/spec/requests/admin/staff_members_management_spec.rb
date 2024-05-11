require 'rails_helper'

  describe "管理者による職員管理","ログイン前" do
    include_examples "a protected admin controller", "admin/staff_members"
    # spec/support下ファイルのinclude_examples "内容",検証したい
  end

  describe "管理者による職員管理" do
    let(:administrator) {create(:administrator)}
    # 上は、複雑な説明があったが要するに
    # 「あらかじめfactory_botで設定した値の投稿を作成しておく」
    # なんて理解で正しいやつ？
    #
    # letは、「メモ化されたヘルパーメソッド」を定義するもの。(?)

    before do
      post admin_session_url,
        params: {
          admin_login_form: {
            email: administrator.email,
            password: "soccer"
          }
        }
    end
    # ユーザー以外入れない領域を追加した時はこれを。
    # 架空の職員がフォームからログインした場合と処理は同じだ。

    describe "新規登録" do
      let(:params_hash) {attributes_for(:staff_member)}
      # attributes_forは、「値を持っていない場合にこの内容で作成する」
      # ということらしい

      example "職員一覧ページにリダイレクト" do
        post admin_staff_members_url, params: {staff_member: params_hash}
        expect(response).to redirect_to(admin_staff_members_url)
          # postは、rspec内で擬似的にhttpポストができる代物。
      end


      example "例外ActionController::ParameterMissingが発生" do
        expect { post admin_staff_members_url }.
          to raise_error(ActionController::ParameterMissing)
      end

    end

    describe "一覧" do
      let(:administrator){create(:administrator)}

      example "成功" do
        get admin_staff_members_url
        expect(response.status).to eq(200)
      end

      example "アカウント停止がセットされたら強制ログアウト" do
        administrator.update_column(:suspended, true)
        get admin_staff_members_url
        # ↑ あそっか…管理者を摘み出されるのかと思ったら、
        # 単に職員を摘み出しただけだから自分には影響はなく
        # 一覧に戻るだけだったのか
        expect(response).to redirect_to(admin_root_url)
      end

      example "セッションタイムアウト" do
        travel_to Admin::Base::TIMEOUT.from_now.advance(seconds:1)

        get admin_staff_members_url
        expect(response).to redirect_to(admin_login_url)
      end


    end



    describe "更新" do
      let(:staff_member) {create(:staff_member)}
      let(:params_hash) {attributes_for(:staff_member)}

      example "suspendedフラグをセットする" do
        params_hash.merge!(suspended: true)
        # merge!を使って、一部パラメータを入れ替えている。
        patch admin_staff_member_url(staff_member),
          params: {staff_member: params_hash}
        # patchは、postの別バージョン。
        staff_member.reload
        expect(staff_member).to be_suspended
        # be_(パラメータ名)は、trueなら成功、falseならテスト失敗の扱いとなる。

    end


    example "hashed_passwordの書き換えは不可能" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect{
        patch admin_staff_member_url(staff_member),
          params: {staff_member: params_hash}
      }.not_to change{staff_member.hashed_password.to_s}
      # to_sは、「文字列に変換する処理」と思われる。

    end


  end

 end
