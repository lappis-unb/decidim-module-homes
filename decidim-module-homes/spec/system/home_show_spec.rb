# frozen_string_literal: true

require "spec_helper"

describe "Show a home", type: :system do
  include_context "with a component"
  let(:manifest_name) { "homes" }

  let(:body) do
    {
      "en" => "<p>Content</p>",
      "ca" => "<p>Contingut</p>",
      "es" => "<p>Contenido</p>"
    }
  end

  let!(:home_component) { create(:home, component: component, body: body) }

  describe "home show" do
    it_behaves_like "editable content for admins" do
      let(:target_path) { main_component_path(component) }
    end

    context "when requesting the home path" do
      before do
        visit_component
      end

      it_behaves_like "accessible home"
      it_behaves_like "has embedded video in description", :body

      it "renders the content of the home" do
        expect(home).to have_content("Content")
      end
    end
  end
end
