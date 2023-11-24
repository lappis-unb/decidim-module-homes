# frozen_string_literal: true

require "decidim/components/namer"

Decidim.register_component(:homes) do |component|
  component.engine = Decidim::Homes::Engine
  component.admin_engine = Decidim::Homes::AdminEngine
  component.icon = "media/images/decidim_homes.svg"
  component.serializes_specific_data = true
  component.specific_data_serializer_class_name = "Decidim::Homes::DataSerializer"
  component.specific_data_importer_class_name = "Decidim::Homes::DataImporter"
  component.permissions_class_name = "Decidim::Homes::Permissions"

  component.query_type = "Decidim::Homes::HomesType"

  component.on(:create) do |instance|
    Decidim::Homes::CreateHome.call(instance) do
      on(:invalid) { raise "Can't create home" }
    end
  end

  component.on(:destroy) do |instance|
    Decidim::Homes::DestroyHome.call(instance) do
      on(:error) { raise "Can't destroy home" }
    end
  end

  component.on(:copy) do |context|
    Decidim::Homes::CopyHome.call(context) do
      on(:invalid) { raise "Can't duplicate home" }
    end
  end

  component.register_stat :homes_count do |components, start_at, end_at|
    homes = Decidim::Homes::Home.where(component: components)
    homes = homes.where("created_at >= ?", start_at) if start_at.present?
    homes = homes.where("created_at <= ?", end_at) if end_at.present?
    homes.count
  end

  component.settings(:global) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.settings(:step) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.register_resource(:home) do |resource|
    resource.model_class_name = "Decidim::Homes::Home"
  end

  component.seeds do |participatory_space|
    component = Decidim::Component.create!(
      name: Decidim::Components::Namer.new(participatory_space.organization.available_locales, :homes).i18n_name,
      manifest_name: :homes,
      published_at: Time.current,
      participatory_space: participatory_space
    )

    Decidim::Homes::Home.create!(
      component: component,
      body: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
        Decidim::Faker::Localized.paragraph(sentence_count: 3)
      end
    )
  end
end
