# frozen_string_literal: true

class CreateDecidimHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_homes_homes do |t|
      t.jsonb :title
      t.references :decidim_feature, index: true
      t.boolean :statistics, default: false
      t.boolean :news, default: false
      t.integer :news_id
      t.string :banner
      t.jsonb :organizers, default: []

      t.timestamps
    end
  end
end
