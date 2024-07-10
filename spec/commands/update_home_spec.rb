# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Homes
    module Admin
      describe UpdateHome do
        let(:current_organization) { create(:organization) }
        let(:user) { create(:user, organization: current_organization) }
        let(:participatory_process) { create(:participatory_process, organization: current_organization) }
        let(:component) { create(:component, manifest_name: "homes", participatory_space: participatory_process) }
        let(:home) { create(:home, component: component, meetings_map: false) }
        let(:form_params) do
          {
            "body" => { "en" => "My new body" },
            "meetings_map" => true
          }
        end
        let(:form) do
          HomeForm.from_params(
            form_params
          ).with_context(
            current_user: user,
            current_organization: current_organization
          )
        end
        let(:command) { described_class.new(form, home) }

        describe "when the form is invalid" do
          before do
            allow(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the home" do
            expect(home).not_to receive(:update!)
            command.call
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "updates the home with the new attributes" do
            expect(home).to receive(:update!).with(
              body: form.body,
              meetings_map: form.meetings_map
            )
            command.call
          end

          it "traces the action", versioning: true do
            expect(Decidim.traceability)
              .to receive(:update!)
              .with(home, user, body: form.body, meetings_map: form.meetings_map)
              .and_call_original

            expect { command.call }.to change(Decidim::ActionLog, :count)
            action_log = Decidim::ActionLog.last
            expect(action_log.version).to be_present
            expect(action_log.version.event).to eq "update"
          end
        end
      end
    end
  end
end
