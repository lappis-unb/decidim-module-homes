# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        include TranslatableAttributes

        attribute :statistics, Boolean, default: false
        attribute :news, Boolean, default: false
        attribute :news_id, Integer
        attribute :banner, Homes::ImageUploader
        attribute :organizers, Homes::ImageUploader
      end
    end
  end
end
