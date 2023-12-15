# frozen_string_literal: true

require "spec_helper"

describe "Preview homes with share token", type: :system do
  let(:manifest_name) { "homes" }

  let(:body) do
    {
      "en" => "<p>Content</p>",
      "ca" => "<p>Contingut</p>",
      "es" => "<p>Contenido</p>"
    }
  end

  let!(:home_component) { create(:home, component: component, body: body) }

  include_context "with a component"
  it_behaves_like "preview component with share_token"
end
