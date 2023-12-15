# frozen_string_literal: true

require "decidim/core"

module Decidim
  module Homes
    # This is the engine that runs on the public interface of `decidim-homes`.
    # It mostly handles rendering the created home associated to a participatory
    # process.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Homes

      routes do
        resources :homes, only: [:show], controller: :application
        root to: "application#show"
      end

      initializer "decidim_homes.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
