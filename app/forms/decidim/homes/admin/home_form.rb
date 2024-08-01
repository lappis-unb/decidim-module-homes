# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        attribute :field_orders, Array[String], default: []
      end
    end
  end
end
