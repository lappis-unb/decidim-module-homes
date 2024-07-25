# frozen_string_literal: true

module Decidim
  module Homes
    # This is the admin interface for `decidim-homes`. It lets you edit and
    # configure the home associated to a participatory process.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Homes::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        post "/", to: "homes#update", as: :home
        root to: "homes#edit"

        resources :home_elements, only: [:new, :create, :edit, :update]
      end

      def load_seed
        nil
      end
    end
  end
end
