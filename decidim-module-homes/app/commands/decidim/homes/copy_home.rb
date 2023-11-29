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
              statistics: home.statistics,         
              news: home.news,                     
              news_id: home.news_id,               
              organizers: home.organizers          
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
