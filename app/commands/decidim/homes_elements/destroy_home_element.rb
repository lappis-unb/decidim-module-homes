# frozen_string_literal: true

module Decidim
  module HomeElements
    # Command that gets called when a home element needs to be destroyed.
    class DestroyHomeElement < Decidim::Command
      def initialize(home_element)
        @home_element = home_element
      end

      def call
        @home_element.destroy!
        broadcast(:ok)
      end
    end
  end
end
