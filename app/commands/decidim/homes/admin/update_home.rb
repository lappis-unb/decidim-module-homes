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
            banner: @form.banner,
            digital_stage: @form.digital_stage,
            organize_stage: @form.organize_stage,
            schedule: @form.schedule,
            common_questions: @form.common_questions,
            support_material: @form.support_material,
            statistics: @form.statistics,
            news: @form.news,
            news_id: @form.news_id || decidim_blogs_placeholder,
            organizers: @form.organizers,
            supporters: @form.supporters
          )
        end

        # Returns a sample decidim blog that belongs to the current participatory space
        #
        def decidim_blogs_placeholder
          Decidim::Component.where(participatory_space: @form.current_participatory_space, manifest_name: "blogs").first&.id
        end
      end
    end
  end
end
