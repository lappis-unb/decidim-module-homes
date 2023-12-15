# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    describe CopyHome do
      describe "call" do
        let(:component) { create(:component, manifest_name: "homes") }
        let!(:home) { create(:home, component: component) }
        let(:new_component) { create(:component, manifest_name: "homes") }
        let(:context) { { new_component: new_component, old_component: component } }
        let(:command) { described_class.new(context) }

        describe "when the home is not duplicated" do
          before do
            allow(Home).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't duplicate the home" do
            expect do
              command.call
            end.not_to change(Home, :count)
          end
        end

        describe "when the home is duplicated" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "duplicates the home and its values" do
            expect(Home).to receive(:create!).with(component: new_component, body: home.body).and_call_original

            expect do
              command.call
            end.to change(Home, :count).by(1)
          end
        end
      end
    end
  end
end
