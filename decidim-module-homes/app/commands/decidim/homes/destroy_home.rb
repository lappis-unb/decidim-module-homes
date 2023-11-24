# frozen_string_literal: true

module Decidim
  module Homes
    # Command that gets called when the home of this component needs to be
    # destroyed. It usually happens as a callback when the component is removed.
    class DestroyHome < Decidim::Command
      def initialize(component)
        @component = component
      end

      def call
        Home.where(component: @component).destroy_all
        broadcast(:ok)
      end
    end
  end
end
