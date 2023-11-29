# frozen_string_literal: true

module Decidim
  module Homes
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::Basecontroller`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Components::BaseController
      helper_method :posts, :post
      
      def show
        @home = Home.find_by(component: current_component)
      end

      def post
        @post ||= posts.find(params[:news_id])
      end

      def posts
        @posts ||= Post.where(component: news_id)
      end
    end
  end
end
