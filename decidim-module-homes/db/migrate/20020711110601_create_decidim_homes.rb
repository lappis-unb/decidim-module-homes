# frozen_string_literal: true


class CreateDecidimHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_homes_homes do |t|
      t.jsonb :title
      t.jsonb :body
      t.references :decidim_feature, index: true
      t.string :banner # Campo para armazenar o caminho da imagem
      t.boolean :statistics, default: false # Campo booleano para Statistics
      t.boolean :news, default: false # Campo booleano para News
      t.integer :news_id # Campo inteiro para id news
      t.jsonb :organizers, default: [] # Campo para armazenar uma lista de imagens para organizers

      t.timestamps
    end
  end
end
