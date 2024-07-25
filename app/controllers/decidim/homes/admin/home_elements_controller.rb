module Decidim
  module Homes
    module Admin
      class HomeElementsController < Admin::ApplicationController
        def new
          type = params[:type]
          home_id = params[:component_id]

          Decidim::HomesElements::CreateHomeElement.call(type: type, properties: "", home_id: home_id) do
            on(:ok) do
              flash[:notice] = "PORRA PORRA PORRA, DEU CERTO CARALHO"
              redirect_to request.referer
            end

            on(:invalid) do
              flash.now[:alert] = "PORRA PORRA PORRA, DEU ERRADO CARALHO"
            end
          end
        end
      end
    end
  end
end
