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

      def show
        @home = Home.find_by(component: current_component)
        @supporters = supporters
        @organizers = organizers
        @steps = steps
        @elements = Decidim::Homes::HomeElements.where(decidim_homes_home_id: @home.id)
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

      def steps
        participatory_space.try(:steps) || []
      end
    end
  end
end
