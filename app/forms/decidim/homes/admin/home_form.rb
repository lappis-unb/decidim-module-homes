# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        attribute :header_title, String
        attribute :header_subtitle, String
        attribute :steps_title, String
        attribute :steps_subtitle, String
        attribute :emphasis_title, String
        attribute :emphasis_subtitle, String
        attribute :emphasis_button_text, String
        attribute :emphasis_link, String
        attribute :participation_title, String
        attribute :participation_subtitle, String
        attribute :map_able, Boolean, default: false
        attribute :statistics, Boolean, default: false
        attribute :digital_stage, String, default: '/'
        attribute :organize_stage, String, default: '/'
        attribute :schedule, String, default: '/'
        attribute :common_questions, String, default: '/'
        attribute :support_material, String, default: '/'
        attribute :news, Boolean, default: false
        attribute :news_id, Integer
        attribute :banner, ImageUploader, default: ''
        attribute :organizers, ImageUploader, default: ''
        attribute :supporters, ImageUploader, default: ''
      end
    end
  end
end
