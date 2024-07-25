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
        def initialize(form, home_element)
          @form = form
          @home_element = home_element
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            update_home_element
            broadcast(:ok)
          end
        end

        private

        attr_reader :form, :home_element

        def update_home_element
          home_element.assign_attributes(form.attributes)
          home_element.save!
        end
      end
    end
  end
end
