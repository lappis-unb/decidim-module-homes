# frozen_string_literal: true

module Decidim
  module Homes
    # Custom helpers, scoped to the homes engine.
    #
    module ApplicationHelper
      def initial_page_components
        @initial_page_components ||= [
          OpenStruct.new(name: "header"),
          OpenStruct.new(name: "news"),
          OpenStruct.new(name: "brazil_map"),
          OpenStruct.new(name: "call_to_action"),
          OpenStruct.new(name: "carrossel"),
          OpenStruct.new(name: "logos_section"),
          OpenStruct.new(name: "steps"),
          OpenStruct.new(name: "cards")
        ]
      end

      def get_card_partial(card_type)
        partials = {
          "participatory" => "participatory_cards",
          "description" => "description_cards",
          "step" => "step_cards"
        }

        partials[card_type]
      end

      def home_carousel
        [
          {
            link: '',
            image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBbEUwIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8ff80e6cbfb602b366ba0875200447d153741c23/Banner%206%C2%AA%20CNSAN%20-%20Mobile.png',
            desktop_image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBbEEwIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--528ef39bc15ebe1a2e5cffbfc8498d218c205286/Banner%206%C2%AA%20CNSAN%20-%20Desktop.png',
            alt_text: '6º Conferencia Nacional de Segurança Alimentar e Nutricional',
            step_info: 'Consea',
            active: true
          },
          {
            link: '',
            image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcWxSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d4ad8c163f14875c268095860204dbd6f659b449/Comunicados_banner_consea.png',
            desktop_image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcWxSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d4ad8c163f14875c268095860204dbd6f659b449/Comunicados_banner_consea.png',
            alt_text: 'Comunicados da 6º Conferencia Nacional de Segurança Alimentar e Nutricional',
            step_info: 'Comunicados',
            active: false
          },
          {
            link: '',
            image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcWxSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d4ad8c163f14875c268095860204dbd6f659b449/Comunicados_banner_consea.png',
            desktop_image_url: 'https://brasilparticipativo.presidencia.gov.br/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcWxSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d4ad8c163f14875c268095860204dbd6f659b449/Comunicados_banner_consea.png',
            alt_text: 'Comunicados da 6º Conferencia Nacional de Segurança Alimentar e Nutricional',
            step_info: 'Comunicados',
            active: false
          }
        ]
      end

      def fetch_news_data(id_component, highlight_latest = false)
        highlight_latest_news_limit = 4
        regular_news_limit = 3

        component = Decidim::Component.where(id: id_component).first

        limit = highlight_latest ? highlight_latest_news_limit : regular_news_limit

        return [] unless component

        Decidim::Blogs::Post
          .where(decidim_component_id: component.id)
          .order(created_at: :desc)
          .limit(limit)
      end
    end
  end
end
