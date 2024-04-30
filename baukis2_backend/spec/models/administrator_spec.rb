require 'rails_helper'

RSpec.describe Administrator, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "#password=" do
    example "文字列を与えると、hashed_passwordは長さ60字の文字列になる" do
      admin = Administrator.new
      admin.password = "baukis"
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end


    example "nilを与えると、hashed_passwordはnilになる" do
      admin = Administrator.new(hashed_password: "y")
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end

  end
end
