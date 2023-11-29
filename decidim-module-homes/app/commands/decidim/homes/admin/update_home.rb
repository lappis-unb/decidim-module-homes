# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This command is executed when the user changes a Home from the admin
      # panel.
      class UpdateHome < Decidim::Command
        # Initializes a UpdateHome Command.
        #
        # form - The form from which to get the data.
        # home - The current instance of the home to be updated.
        def initialize(form, home)
          @form = form
          @home = home
        end

        # Updates the home if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          update_home
          broadcast(:ok)
        end

        private

        def update_home
          Decidim.traceability.update!(
            @home,
            @form.current_user,
            statistics: @form.statistics,
            news: @form.news,
            news_id: @form.news_id,
            banner: @form.banner,
            organizers: @form.organizers
          )
        end
      end
    end
  end
end
