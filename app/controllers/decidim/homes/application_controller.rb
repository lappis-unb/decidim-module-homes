# frozen_string_literal: true

module Decidim
  module Homes
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::Basecontroller`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Components::BaseController
      helper_method :organizers
      helper_method :supporters
      helper_method :latest_posts

      def show
        @home = Home.find_by(component: current_component)
        @supporters = supporters
        @organizers = organizers
        @latest_posts = latest_posts
        @steps = steps
      end

      private

      def participatory_space
        current_participatory_space
      end

      def supporters
        participatory_space.try(:supporters) || []
      end

      def organizers
        participatory_space.try(:organizers) || []
      end

      def latest_posts
        Rails.cache.fetch("decidim_homes_home_#{@home.id}_blogs_#{@home.news_id}_latest_3_posts", expires_in: 2.minutes) do
          @home.news_section_enabled? ? Decidim::Blogs::Post.where(component: @home.news_id).order(created_at: :desc).limit(3) : []
        end
      end

      def steps
        participatory_space.try(:steps) || []
      end
    end
  end
end
