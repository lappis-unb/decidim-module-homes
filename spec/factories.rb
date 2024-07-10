# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/participatory_processes/test/factories"

FactoryBot.define do
  factory :home_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :homes).i18n_name }
    manifest_name { :homes }
    participatory_space { create(:participatory_process, :with_steps, organization: organization) }
  end

  factory :home, class: "Decidim::Homes::Home" do
    body { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_title } }
    component { build(:component, manifest_name: "homes") }
    meetings_map { false }
  end
end
