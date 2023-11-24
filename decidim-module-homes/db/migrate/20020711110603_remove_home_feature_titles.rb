# frozen_string_literal: true

class RemoveHomeFeatureTitles < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_homes_homes, :title
  end
end
