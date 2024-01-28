# frozen_string_literal: true

module Decidim
  module Homes
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::Basecontroller`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Components::BaseController
      before_action :set_home, only: [:show]
      before_action :set_news, only: [:show]

      helper_method :organizers
      helper_method :supporters

      def show; end

      private

      def set_home
        @home = Home.find_by(component: current_component)
      end

      def set_news
        return unless @home.news

        @home.news_posts ||= []
        Decidim::Blogs::Post.where(component: @home.news_id)
                            .order(created_at: :desc)
                            .limit(3)
                            .each do |post|
          @home.news_posts << post
        end
      end

      def participatory_space
        current_participatory_space
      end

      def supporters
        participatory_space.try(:supporters) || []
      end

      def organizers
        participatory_space.try(:organizers) || []
      end
    end
  end
end
