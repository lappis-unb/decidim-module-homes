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

          if @home_element.element_type == "cards"
            @available_card_types ||= [
              [t("decidim.components.cards.type.participatory"), 'participatory'],
              [t("decidim.components.cards.type.description"), 'description']
            ]
          end

          if @home_element.element_type == "official_logos"
            @available_logos_types ||= [
              [t("decidim.components.official_logos.type.cultura"), 'cultura'],
              [t("decidim.components.official_logos.type.g20"), 'g20']
            ]
          end

          render :edit
        end

        def update
          home_id = params[:component_id]
          home_element_id = params[:id]
          properties = params[:home_elements][:properties]

          if properties["card_type"]
            properties[:items] = []
            items = params[:items].to_unsafe_h.sort_by { |_key, value| value["weight"] }

            if properties["card_type"] == "participatory"
              items.each do |_key, value|
                properties[:items].push({ 'title' => value['title'], 'link' => value['link'], 'icon' => value['icon'] })
              end
            end

            if properties["card_type"] == "description"
              items.each do |_key, value|
                properties[:items].push({
                                          'label' => value['label'],
                                          'title' => value['title'],
                                          'description' => value['description']
                                        })
              end
            end
          end

          Decidim::HomesElements::Admin::UpdateHomeElement.call(home_element_id: home_element_id, home_id: home_id, properties: properties, current_user: current_user) do
            on(:ok) do
              flash[:notice] = "Elemento atualizado com sucesso"
              redirect_to request.url.split("/")[0..8].join("/")
            end

            on(:invalid) do
              flash.now[:alert] = "Erro ao atualizar o elemento"
            end
          end
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
