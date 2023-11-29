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
      include Decidim::TranslatableResource

      translatable_fields :body

      component_manifest_name "homes"

      attribute :statistics, :boolean, default: false
      attribute :news, :boolean, default: false
      attribute :news_id, :integer

      mount_uploader :banner, ImageUploader
      mount_uploaders :organizers, ImageUploader

      belongs_to :blogs, class_name: "Decidim::Blogs", foreign_key: "news_id", optional: true

      def self.log_presenter_class_for(_log)
        Decidim::Homes::AdminLog::HomePresenter
      end

      def title
        component.name
      end
    end
  end
end
