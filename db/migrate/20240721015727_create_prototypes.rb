class CreatePrototypes < ActiveRecord::Migration[7.0]
  def change
    create_table :prototypes do |t|
      # model作成時に追加したもの
      t.string :title,      null: false
      t.text   :catch_copy, null: false
      t.text   :concept,    null: false
      # references型の外部キー
      t.references :user,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
