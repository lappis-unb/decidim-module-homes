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
              body: home.body,
              banner: home.banner,                 # Add this line for the banner attribute
              statistics: home.statistics,         # Add this line for the statistics attribute
              news: home.news,                     # Add this line for the news attribute
              news_id: home.news_id,               # Add this line for the news_id attribute
              organizers: home.organizers          # Add this line for the organizers attribute
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
