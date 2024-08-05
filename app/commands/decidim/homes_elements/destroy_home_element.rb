# frozen_string_literal: true

module Decidim
  module HomesElements
    class DestroyHomeElement < Decidim::Command
      def initialize(params)
        @home_element_id = params[:home_element_id]
        @home_id = params[:home_id]
      end

      def call
        transaction do
          delete_home_element
        end

        broadcast(:ok)
      end

      def delete_home_element
        home = Decidim::Homes::Home.where(decidim_component_id: @home_id).first

        home.home_elements.find_by(id: @home_element_id).destroy!
        home.save!
      end
    end
  end
end
