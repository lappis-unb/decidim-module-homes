module Decidim
  module Homes
    module Admin
      class HomeElementsController < Admin::ApplicationController
        def new
          type = params[:type]
          home_id = params[:component_id]

          Decidim::HomesElements::CreateHomeElement.call(type: type, properties: "", home_id: home_id) do
            on(:ok) do
              flash[:notice] = "Elemento criado com sucesso"
              redirect_to request.referer
            end

            on(:invalid) do
              flash.now[:alert] = "Erro ao criar o elemento"
            end
          end
        end

        def edit
          home_id = params[:component_id]
          home_element = Homes::Home.find_by(decidim_component_id: home_id)

          @home_element = home_element.home_elements.find_by(id: params[:id])

          render :edit
        end

        def update
          redirect_to :back
        end

        def destroy
          home_element_id = params[:id]
          home_id = params[:component_id]

          Decidim::HomesElements::DestroyHomeElement.call(home_element_id: home_element_id, home_id: home_id) do
            on(:ok) do
              flash[:notice] = "Elemento removido com sucesso"
              redirect_to request.referer
            end

            on(:invalid) do
              flash.now[:alert] = "Erro ao remover o elemento"
            end
          end
        end
      end
    end
  end
end
