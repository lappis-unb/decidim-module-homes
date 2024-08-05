module Decidim
  module HomesElements
    class CreateHomeElement < Decidim::Command
      def initialize(params)
        @type = params[:type]
        @properties = params[:properties]
        @home_id = params[:home_id]
      end

      def call
        transaction do
          create_home_element
        end

        broadcast(:ok)
      end

      private

      def create_home_element
        home = Decidim::Homes::Home.where(decidim_component_id: @home_id).first

        @home_element = home.home_elements.new(
          element_type: @type,
          properties: @properties,
          decidim_homes_home_id: @home_id
        )
        @home_element.save!
      end
    end
  end
end
