module Decidim
  module Homes
    class ImageUploader < CarrierWave::Uploader::Base
      include CarrierWave::MiniMagick

      storage :file

      def validate_integrity
        errors.add(:file, 'cannot be empty') if file.blank?
      end

      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end

      version :thumb do
        process resize_to_fit: [200, 200]
      end

      def extension_whitelist
        %w(jpg jpeg gif png)
      end

      def content_type_whitelist
        [%r{image/}]
      end
    end
  end
end
