# frozen_string_literal: true

module Decidim
  module Homes
    # The data store for a Home in the Decidim::Homes component. It stores a
    # title, description and any other useful information to render a custom home.
    class Home < Homes::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::HasComponent
      include Decidim::Traceable
      include Decidim::Loggable

      has_many :home_elements, dependent: :destroy, class_name: "Decidim::Homes::HomeElements", foreign_key: "decidim_homes_home_id"
      component_manifest_name "homes"

      attribute :digital_stage, :string, default: '/'
      attribute :organize_stage, :string, default: '/'
      attribute :schedule, :string, default: '/'
      attribute :common_questions, :string, default: '/'
      attribute :support_material, :string, default: '/'
      attribute :field_orders, :jsonb, default: []
      attribute :participation_title, :string
      attribute :participation_subtitle, :string
      attribute :reverse_call_to_action, :boolean, default: false

      mount_uploader :banner, Decidim::Homes::ImageUploader, default: ''

      def self.log_presenter_class_for(_log)
        Decidim::Homes::AdminLog::HomePresenter
      end

      def title
        component.name
      end

      def news_section_enabled?
        news
      end
    end
  end
end
