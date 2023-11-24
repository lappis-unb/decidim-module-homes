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
            body: @form.body,
            banner: @form.banner,             # Add this line for the banner attribute
            statistics: @form.statistics,     # Add this line for the statistics attribute
            news: @form.news,                 # Add this line for the news attribute
            news_id: @form.news_id,           # Add this line for the news_id attribute
            organizers: @form.organizers      # Add this line for the organizers attribute
          )
        end
      end
    end
  end
end
