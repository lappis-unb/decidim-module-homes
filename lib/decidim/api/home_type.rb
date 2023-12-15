# frozen_string_literal: true

module Decidim
  module Homes
    class HomeType < Decidim::Api::Types::BaseObject
      description "A home"

      field :id, GraphQL::Types::ID, null: false
      field :title, Decidim::Core::TranslatedFieldType, "The title of this home (same as the component name).", null: false
      field :body, Decidim::Core::TranslatedFieldType, "The body of this home.", null: true
      field :created_at, Decidim::Core::DateTimeType, "The time this home was created", null: false
      field :updated_at, Decidim::Core::DateTimeType, "The time this home was updated", null: false
    end
  end
end
