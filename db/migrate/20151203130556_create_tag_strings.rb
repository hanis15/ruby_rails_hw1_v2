class CreateTagStrings < ActiveRecord::Migration
  def change
    create_table :tag_strings do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :posts_tag_strings, id: false do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag_string, index: true
    end
  end
end
