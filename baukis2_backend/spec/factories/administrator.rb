FactoryBot.define do
# factoryBotのデータを作りたいときは、FactoryBot.define do … endとするといい。

  factory :administrator do
    sequence(:email) { |n| "member#{n}@example.com" }
    # family_name { "谷畑" }
    # given_name { "花子" }
    # family_name_kana { "タニハタ" }
    # given_name_kana { "ハナコ" }
    password { "soccer" }
    # start_date { Date.yesterday }
    # end_date { nil }
    suspended { false }
  end


end


# factoryのデータは、いわばテスト(spec)用のseedデータ、といったところ。
