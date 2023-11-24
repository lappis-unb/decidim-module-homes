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

      # Adicione os novos campos ao modelo
      # Campos adicionados: banner, statistics, news, news_id, organizers
      attribute :banner, :string
      attribute :statistics, :boolean, default: false
      attribute :news, :boolean, default: false
      attribute :news_id, :integer
      has_many_attached :organizers

      def self.log_presenter_class_for(_log)
        Decidim::Homes::AdminLog::HomePresenter
      end

      # Public: Homes doesn't have title so we assign the component one to it.
      def title
        component.name
      end
    end
  end
end
