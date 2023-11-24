# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/component_context"
require "decidim/budgets/test/factories"

describe "Decidim::Api::QueryType" do
  include_context "with a graphql decidim component"
  let(:component_type) { "Homes" }
  let!(:current_component) { create :home_component, participatory_space: participatory_process }
  let!(:home) { create(:home, component: current_component) }

  let(:home_single_result) do
    {
      "body" => { "translation" => home.body[locale] },
      "createdAt" => home.created_at.iso8601.to_s.gsub("Z", "+00:00"),
      "id" => home.id.to_s,
      "title" => { "translation" => home.title[locale] },
      "updatedAt" => home.updated_at.iso8601.to_s.gsub("Z", "+00:00")
    }
  end

  let(:home_data) do
    {
      "__typename" => "Homes",
      "id" => current_component.id.to_s,
      "name" => { "translation" => "Home" },
      "homes" => {
        "edges" => [
          {
            "node" => home_single_result
          }
        ]
      },
      "weight" => 0
    }
  end

  describe "valid connection query" do
    let(:component_fragment) do
      %(
      fragment fooComponent on Homes {
        homes{
          edges{
            node{
              body {
                translation(locale:"#{locale}")
              }
              createdAt
              id
              title {
                translation(locale:"#{locale}")
              }
              updatedAt
            }
          }
        }
      }
)
    end

    it "executes sucessfully" do
      expect { response }.not_to raise_error
    end

    it { expect(response["participatoryProcess"]["components"].first).to eq(home_data) }
  end

  describe "valid query" do
    let(:component_fragment) do
      %(
      fragment fooComponent on Homes {
        home(id: #{home.id}){
          body {
            translation(locale:"#{locale}")
          }
          createdAt
          id
          title {
            translation(locale:"#{locale}")
          }
          updatedAt
        }
      }
)
    end

    it "executes sucessfully" do
      expect { response }.not_to raise_error
    end

    it { expect(response["participatoryProcess"]["components"].first["home"]).to eq(home_single_result) }
  end
end
