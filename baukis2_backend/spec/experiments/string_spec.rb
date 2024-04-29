require "spec_helper"

describe String do
  describe "#<<" do

    example "文字の追加" do
      s = "abc"
      s << "d"
      expect(s.size).to eq(4)
    end

    # 英語表記にする場合以下表現も上と同義
    # it "appends a character" do
    #   s = "abc"
    #   s << "d"
    #   expect(s.size).to eq(4)
    # end

    example "nilの追加" do
      pending("調査中")
      s = "abc"
      s << nil
      expect(s.size).to eq(4)
    end

    # 「xexample」をexampleの代わりに使用すればendingいらず
    # xexample "nilの追加" do
    #   pending("調査中")
    #   s = "abc"
    #   s << nil
    #   expect(s.size).to eq(4)
    # end


    example "nilは追加できない", :exception do
      # 「:exception」のように、「:~」とあるものはタグに当たり、
      # 「rspec --tag=~」とすれば指定のタグのものだけテストが行えるぞ。
      s = "ABC"
      expect { s << nil }.to raise_error(TypeError)
    end



  end
end
