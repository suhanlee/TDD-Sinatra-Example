class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :subject
      t.text :contents
    end
  end
end
