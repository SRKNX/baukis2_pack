require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードならtrueを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticate("soccer")).to be_truthy
    end

    example "誤ったパスワードならfalseを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticate("baseball")).to be_falsey
    end

    example "パスワード未設定ならfalseを返す" do
      a = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(a).authenticate(nil)).to be_falsey
    end

    example "停止フラグが立っていればfalseを返す" do
      pending("調査中")

      a = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(a).authenticate("soccer")).to be_falsey
    end
    # 利用停止機能を実装するまでしばらく休止。実装次第再開。

    example "停止フラグが立っていてもtrueを返す" do
      pending("調査中")
      a = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(a).authenticate("soccer")).to be_truthy

    end
    # 利用停止機能を実装するまでこちらを使用。実装次第休止。

    # example "開始前ならfalseを返す" do
    #   a = build(:administrator, start_date: Date.tomorrow)
    #   expect(Admin::Authenticator.new(a).authenticate("soccer")).to be_falsey
    # end
    #
    # example "終了後ならfalseを返す" do
    #   a = build(:administrator, end_date: Date.today)
    #   expect(Admin::Authenticator.new(a).authenticate("soccer")).to be_falsey
    # end
    # ↑ start_dateとend_dateのカラムはないため不要
  end
end
