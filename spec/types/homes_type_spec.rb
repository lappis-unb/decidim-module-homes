# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"
require "decidim/core/test"

module Decidim
  module Homes
    describe HomesType, type: :graphql do
      include_context "with a graphql class type"
      let(:model) { create(:home_component) }

      it_behaves_like "a component query type"

      describe "homes" do
        let!(:component_homes) { create_list(:home, 2, component: model) }
        let!(:other_homes) { create_list(:home, 2) }

        let(:query) { "{ homes { edges { node { id } } } }" }

        it "returns the published homes" do
          ids = response["homes"]["edges"].map { |edge| edge["node"]["id"] }
          expect(ids).to include(*component_homes.map(&:id).map(&:to_s))
          expect(ids).not_to include(*other_homes.map(&:id).map(&:to_s))
        end
      end

      describe "home" do
        let(:query) { "query Home($id: ID!){ home(id: $id) { id } }" }
        let(:variables) { { id: home.id.to_s } }

        context "when the home belongs to the component" do
          let!(:home) { create(:home, component: model) }

          it "finds the home" do
            expect(response["home"]["id"]).to eq(home.id.to_s)
          end
        end

        context "when the home doesn't belong to the component" do
          let!(:home) { create(:home, component: create(:home_component)) }

          it "returns null" do
            expect(response["home"]).to be_nil
          end
        end
      end
    end
  end
end
