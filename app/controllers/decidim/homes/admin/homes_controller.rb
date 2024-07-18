# frozen_string_literal: true

module Decidim
  module Homes
    module Admin
      # This controller allows the user to update a Home.
      class HomesController < Admin::ApplicationController
        def edit
          enforce_permission_to :update, :home

          @form = form(Admin::HomeForm).from_model(home)
        end

        def update
          enforce_permission_to :update, :home

          @form = form(Admin::HomeForm).from_params(params)

          if params[:home][:field_orders].is_a?(String)
            @form.field_orders = params[:home][:field_orders].split(',')
          end

          Admin::UpdateHome.call(@form, home) do
            on(:ok) do
              flash[:notice] = I18n.t("homes.update.success", scope: "decidim.homes.admin")
              redirect_to parent_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("homes.update.invalid", scope: "decidim.homes.admin")
              render action: "edit"
            end
          end
        end

        private

        def home
          @home ||= Homes::Home.find_by(component: current_component)
        end
      end
    end
  end
end
