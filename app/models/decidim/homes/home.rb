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

      component_manifest_name "homes"

      attribute :statistics, :boolean, default: false
      attribute :digital_stage, :string, default: '/'
      attribute :organize_stage, :string, default: '/'
      attribute :schedule, :string, default: '/'
      attribute :common_questions, :string, default: '/'
      attribute :support_material, :string, default: '/'
      attribute :news, :boolean, default: false
      attribute :news_id, :integer
      attribute :meetings_map, :boolean, default: false
      attribute :field_orders, :jsonb, default: []
      attribute :news_posts, :jsonb, default: []
      attribute :header_title, :string
      attribute :header_subtitle, :string
      attribute :steps_title, :string
      attribute :steps_subtitle, :string
      attribute :emphasis_title, :string
      attribute :emphasis_subtitle, :string
      attribute :emphasis_link, :string
      attribute :emphasis_button_text, :string
      attribute :emphasis_link, :string
      attribute :participation_title, :string
      attribute :participation_subtitle, :string
      attribute :map_able, :boolean, default: false
      attribute :meetings_map, :boolean, default: false

      mount_uploader :banner, Decidim::Homes::ImageUploader, default: ''
      mount_uploaders :organizers, Decidim::Homes::ImageUploader, default: ''
      mount_uploaders :supporters, Decidim::Homes::ImageUploader, default: ''

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
