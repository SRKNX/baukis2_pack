require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードならtrueを返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    example "誤ったパスワードならfalseを返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("xy")).to be_falsey
    end

    example "パスワード未設定ならfalseを返す" do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    # example "停止フラグが立っていればfalseを返す" do
    #   m = build(:staff_member, suspended: true)
    #   expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    # end
    # 利用停止機能を実装するまでしばらく休止。実装次第再開。

    example "停止フラグが立っていてもtrueを返す" do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end
    # 利用停止機能を実装するまでこちらを使用。実装次第休止。

    example "開始前ならfalseを返す" do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end

    example "終了後ならfalseを返す" do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end
  end
end
