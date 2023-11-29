# frozen_string_literal: true

module Decidim
  module Homes
    # Importer for Homes specific data (i.e. its home content).
    class DataImporter < Decidim::Importers::Importer
      def initialize(component)
        @component = component
      end

      # Creates a new Decidim::Homes::Home associated to the given **component**
      # for the serialized home object.
      #
      # @param serialized [Hash] The serialized data read from the import file.
      # @param _user [Decidim::User] The user performing the import.
      # @return [Decidim::Homes::Home] The imported home
      def import(serialized, _user)
        return unless serialized

        Home.create!(
          component: @component,
          banner: serialized["banner"],
          statistics: serialized["statistics"] || false,
          news: serialized["news"] || false,
          news_id: serialized["news_id"],
          organizers: serialized["organizers"]
        )
      end
    end
  end
end
