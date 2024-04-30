FactoryBot.define do
# factoryBotのデータを作りたいときは、FactoryBot.define do … endとするといい。

  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name { "山田" }
    given_name { "太郎" }
    family_name_kana { "ヤマダ" }
    given_name_kana { "タロウ" }
    password { "pw" }
    start_date { Date.yesterday }
    end_date { nil }
    suspended { false }
  end


end


# factoryのデータは、いわばテスト(spec)用のseedデータ、といったところ。
