module Decidim
  module Homes
    class HomeElements < ApplicationRecord
      self.table_name = "decidim_homes_elements"

      belongs_to :home, foreign_key: "decidim_homes_home_id", class_name: "Decidim::Homes::Home"
    end
  end
end
