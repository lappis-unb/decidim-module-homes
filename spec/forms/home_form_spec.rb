# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    module Admin
      describe HomeForm do
        subject do
          described_class.from_params(attributes).with_context(
            current_organization: current_organization
          )
        end

        let(:current_organization) { create(:organization) }

        let(:body) do
          {
            "en" => "<p>Content</p>",
            "ca" => "<p>Contingut</p>",
            "es" => "<p>Contenido</p>"
          }
        end

        let(:commentable) { true }
        let(:meetings_map) { true }

        let(:attributes) do
          {
            "home" => {
              "body" => body,
              "commentable" => commentable,
              "meetings_map" => meetings_map
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid }
        end

        context "when meetings_map is false" do
          let(:meetings_map) { false }

          it "is valid" do
            expect(subject).to be_valid
          end

          it "sets meetings_map to false" do
            expect(subject.meetings_map).to be false
          end
        end
      end
    end
  end
end
