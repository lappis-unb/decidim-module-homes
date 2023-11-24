# frozen_string_literal: true

module Decidim
  module Homes
    class HomesType < Decidim::Api::Types::BaseObject
      implements Decidim::Core::ComponentInterface

      graphql_name "Homes"
      description "A homes component of a participatory space."

      field :homes, Decidim::Homes::HomeType.connection_type, null: true, connection: true

      def homes
        Home.where(component: object).includes(:component)
      end

      field :home, Decidim::Homes::HomeType, null: true do
        argument :id, GraphQL::Types::ID, required: true
      end

      def home(**args)
        Home.where(component: object).find_by(id: args[:id])
      end
    end
  end
end
