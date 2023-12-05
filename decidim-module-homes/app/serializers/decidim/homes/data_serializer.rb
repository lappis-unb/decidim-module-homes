# frozen_string_literal: true

module Decidim
  module Homes
    # This class serializes the specific data in each Home. This is the home
    # data outside of the component settings.
    class DataSerializer < Decidim::Exporters::Serializer
      include Decidim::TranslationsHelper

      # Serializes the home data for this component.
      #
      # @return [Hash] The serialized data
      def serialize
        home = Home.find_by(component: resource)

        {
          body: home&.body || empty_translatable,
          banner: home&.banner,
          statistics: home&.statistics || false,
          news: home&.news || false,
          news_id: home&.news_id,
          organizers: home&.organizers
        }
      end
    end
  end
end
