# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    describe DestroyHome do
      describe "call" do
        let(:component) { create(:component, manifest_name: "homes") }
        let!(:home) { create(:home, component: component) }
        let(:command) { described_class.new(component) }

        it "broadcasts ok" do
          expect { command.call }.to broadcast(:ok)
        end

        it "deletes the home associated to the component" do
          expect do
            command.call
          end.to change(Home, :count).by(-1)
        end
      end
    end
  end
end
