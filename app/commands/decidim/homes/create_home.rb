# frozen_string_literal: true

module Decidim
  module Homes
    # Command that gets called whenever a component's home has to be created. It
    # usually happens as a callback when the component itself is created.
    class CreateHome < Decidim::Command
      def initialize(component)
        @component = component
      end

      def call
        @home = Home.new(component: @component)

        @home.save ? broadcast(:ok) : broadcast(:invalid)
      end
    end
  end
end
