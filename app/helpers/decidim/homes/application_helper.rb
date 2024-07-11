# frozen_string_literal: true

module Decidim
  module Homes
    # Custom helpers, scoped to the homes engine.
    #
    module ApplicationHelper
      def carousel
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
    end
  end
end
