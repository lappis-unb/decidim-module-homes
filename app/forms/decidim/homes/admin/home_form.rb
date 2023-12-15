# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        attribute :statistics, Boolean, default: false
        attribute :digital_stage, String, default: '/'
        attribute :organize_stage, String, default: '/'
        attribute :schedule, String, default: '/'
        attribute :common_questions, String, default: '/'
        attribute :support_material, String, default: '/'
        attribute :news, Boolean, default: false
        attribute :news_id, Integer
        attribute :banner, Homes::ImageUploader
        attribute :organizers, Homes::ImageUploader
        attribute :supporters, Homes::ImageUploader
      end
    end
  end
end
