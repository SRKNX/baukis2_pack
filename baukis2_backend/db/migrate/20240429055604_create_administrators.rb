class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|

      t.string :email, null: false # メールアドレス
        t.string :hashed_password # パスワード
      t.boolean :suspended, null: false, default: false # セッション

      t.timestamps
    end

    add_index :administrators, "LOWER(email)",unique: true
  end
end
