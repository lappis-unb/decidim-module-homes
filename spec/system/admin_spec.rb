# frozen_string_literal: true

require "spec_helper"

describe "Edit a home", type: :system do
  include_context "when managing a component as an admin"
  let(:component) { create(:component, manifest_name: "homes", participatory_space: participatory_process) }
  let(:manifest_name) { "homes" }

  let(:body) do
    {
      "en" => "<p>Content</p>",
      "ca" => "<p>Contingut</p>",
      "es" => "<p>Contenido</p>"
    }
  end

  describe "admin home" do
    before do
      create(:home, component: component, body: body)
      visit_component_admin
    end

    it_behaves_like "having a rich text editor for field", ".tabs-content[data-tabs-content='home-body-tabs']", "full"

    it "updates the home" do
      new_body = {
        en: "<p>New body</p>",
        ca: "<p>Nou cos</p>",
        es: "<p>Nuevo cuerpo</p>"
      }

      within "form.edit_home" do
        fill_in_i18n_editor(:home_body, "#home-body-tabs", new_body)
        find("*[type=submit]").click
      end

      expect(home).to have_admin_callout("successfully")

      visit_component

      expect(home).to have_content("New body")
    end
  end

  describe "announcements" do
    before do
      create(:home, component: component, body: body)
      visit_component_admin
    end

    it_behaves_like "manage announcements"
  end
end
