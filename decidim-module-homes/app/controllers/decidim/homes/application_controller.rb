# frozen_string_literal: true

module Decidim
  module Homes
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::Basecontroller`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Components::BaseController
      def show
        @home = Home.find_by(component: current_component)
      end
    end
  end
end
