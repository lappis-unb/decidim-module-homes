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
      attribute :element_orders, :jsonb, default: []

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
