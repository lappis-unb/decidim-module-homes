class AddOrganizersToHomes < ActiveRecord::Migration[6.1]
  def change
    remove_column :decidim_homes_homes, :organizers
    add_column :decidim_homes_homes, :organizers, :jsonb, default: []
  end
end
