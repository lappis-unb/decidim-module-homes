# frozen_string_literal: true

module Decidim
  module Homes
    # Command that gets called whenever a component's home has to be duplicated.
    # It's needed a context with the old component that
    # is going to be duplicated on the new one
    class CopyHome < Decidim::Command
      def initialize(context)
        @context = context
      end

      def call
        Decidim::Homes::Home.transaction do
          homes = Decidim::Homes::Home.where(component: @context[:old_component])
          homes.each do |home|
            Decidim::Homes::Home.create!(
              component: @context[:new_component],
              banner: home.banner,
              digital_stage: home.digital_stage,
              organize_stage: home.organize_stage,
              schedule: home.schedule,
              common_questions: home.common_questions,
              support_material: home.support_material,
              statistics: home.statistics,
              news: home.news,
              news_id: home.news_id,
              organizers: home.organizers,
              supporters: home.supporters,
              meetings_map: home.meetings_map
            )
          end
        end
        broadcast(:ok)
      rescue ActiveRecord::RecordInvalid
        broadcast(:invalid)
      end
    end
  end
end
