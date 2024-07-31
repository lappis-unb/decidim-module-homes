# frozen_string_literal: true

module Decidim
  module HomesElements
    module Admin
      # This command is executed when the user changes a HomeElement from the admin
      # panel.
      class UpdateHomeElement < Decidim::Command
        # Public: Initializes the command.
        #
        # form - The form from which to get the data.
        # home_element - The current instance of the home_element to be updated.
        def initialize(params)
          @home_element_id = params[:home_element_id]
          @home_id = params[:home_id]
          @properties = params[:properties]
          @current_user = params[:current_user]
        end

        def call
          transaction do
            update_home_element
          end

          broadcast(:ok)
        rescue StandardError => e
          broadcast(:invalid)
          Rails.logger.error("Failed to update home element: #{e.message}")
        end

        private

        def update_home_element
          @home = Decidim::Homes::Home.find_by(decidim_component_id: @home_id)
          @home_element = @home.home_elements.find_by(id: @home_element_id)

          @home_element.assign_attributes(
            properties: @properties
          )

          Decidim.traceability.update!(
            @home_element,
            @current_user,
            decidim_homes_home_id: @home_id,
            home: @home
          )
        end
      end
    end
  end
end
