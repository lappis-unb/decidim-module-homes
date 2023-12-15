# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    describe CreateHome do
      describe "call" do
        let(:component) { create(:component, manifest_name: "homes") }
        let(:command) { described_class.new(component) }

        describe "when the home is not saved" do
          before do
            # rubocop:disable RSpec/AnyInstance
            allow_any_instance_of(Home).to receive(:save).and_return(false)
            # rubocop:enable RSpec/AnyInstance
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't create a home" do
            expect do
              command.call
            end.not_to change(Home, :count)
          end
        end

        describe "when the home is saved" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new home with the same name as the component" do
            expect(Home).to receive(:new).with(component: component).and_call_original

            expect do
              command.call
            end.to change(Home, :count).by(1)
          end
        end
      end
    end
  end
end
