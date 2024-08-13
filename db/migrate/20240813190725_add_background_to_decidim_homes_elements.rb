class AddBackgroundToDecidimHomesElements < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_homes_elements, :background, :string, default: "white"
  end
end
