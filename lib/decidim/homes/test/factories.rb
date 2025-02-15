# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :homes_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :homes).i18n_name }
    manifest_name :homes
    participatory_space { create(:participatory_process, :with_steps) }
  end

  factory :home, class: "Decidim::Homes::Home" do
    title { generate_localized_title }
    component { build(:component, manifest_name: "homes") }
  end
  # Add engine factories here
end
