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
      attribute :news_posts, :jsonb, default: []

      mount_uploader :banner, ImageUploader
      mount_uploaders :organizers, ImageUploader
      mount_uploaders :supporters, ImageUploader

      def self.log_presenter_class_for(_log)
        Decidim::Homes::AdminLog::HomePresenter
      end

      def title
        component.name
      end
    end
  end
end
