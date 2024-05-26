class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|

      t.references :customer, null: false, index: false # 顧客(customer)への外部キー
        t.string :type, null: false # 姓
        t.string :postal_code, null: false # 姓
        t.string :prefecture, null: false # 姓
        t.string :city, null: false # 姓
        t.string :address1, null: false # 姓
        t.string :address2, null: false # 姓
        t.string :company_name, null: false, default: "" # 姓
        # 必須だけど入力は必要ない、という要素は、最後に
        # 「, default: ""」
        # を加えるといい。

        t.string :division_name, null: false, default: "" # 姓



      t.timestamps
    end

    # add_indexは検索とソートの高速化のため。ただしリソースを必要とするため無闇な量産は勧めない
    # "lower"関数は簡単に言えば重複メールアドレス登録防止のため。
    # あとはわからない。pending(保留)。
    add_index :addresses, [ :type, :customer_id ], unique: true

    # 下のコードは、おそらく「staff_member」でソートをかける時、
    # フリガナで検索すると連動してくれる、ということなのだろう。
    add_foreign_key :addresses, :customers


  end
end
