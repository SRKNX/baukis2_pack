class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|

        t.string :email, null: false # メールアドレス
          t.string :family_name, null: false # 姓
          t.string :given_name, null: false # 名
          t.string :family_name_kana, null: false # カナ姓
          t.string :given_name_kana, null: false # カナ名
          t.string :gender, null: false # 性別
          t.date :birthday, null: false # 誕生日
        t.string :hashed_password # パスワード

      t.timestamps
    end

    # add_indexは検索とソートの高速化のため。ただしリソースを必要とするため無闇な量産は勧めない
    # "lower"関数は簡単に言えば重複メールアドレス登録防止のため。
    # あとはわからない。pending(保留)。
    add_index :customers, "LOWER(email)", unique: true

    # 下のコードは、おそらく「staff_member」でソートをかける時、
    # フリガナで検索すると連動してくれる、ということなのだろう。
    add_index :customers, [ :family_name_kana, :given_name_kana ]

  end
end
