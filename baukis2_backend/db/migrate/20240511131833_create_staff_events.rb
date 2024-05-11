class CreateStaffEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :staff_events do |t|

      t.references :staff_member, null: false, index: false, foeign_key: true
      # foeign_keyは、ここでは「職員レコードへの外部キー」。

      t.string :type, null: false # イベントタイプ
      t.datetime :created_at, null: false # 発生時刻

      # t.timestamps
      # ↑ updated_atを使わないため
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [:staff_member_id, :created_at]
    # 上のコードを設定すれば職員別にイベントのリストを発生時刻順に並べ替えたい時に処理が楽に

  end
end
