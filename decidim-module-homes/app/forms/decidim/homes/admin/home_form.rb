# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        include TranslatableAttributes

        translatable_attribute :body, String
        translatable_attribute :banner, String
        translatable_attribute :statistics, Boolean, default: false
        translatable_attribute :news, Boolean, default: false
        translatable_attribute :news_id, Integer
        attribute :organizers

        `validate :banner, presence: true
        validate :validate_organizers_images

        private

        def validate_organizers_images
          return unless organizers.present?

          organizers.each do |image|
            unless image_is_valid?(image)
              errors.add(:organizers, I18n.t("errors.messages.invalid_image_format", scope: "decidim.homes.admin"))
            end
          end
        end

        def image_is_valid?(image)
          allowed_formats = %w[image/jpeg image/png image/gif]

          # Verifica se o tipo MIME da imagem está na lista de formatos permitidos
          allowed_formats.include?(image[:type])
        end
        `
      end
    end
  end
end
