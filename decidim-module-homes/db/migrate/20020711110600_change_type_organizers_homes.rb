# frozen_string_literal: true

class ChangeTypeOrganizersHomes < ActiveRecord::Migration[5.0]
  def change
    # Remover a coluna existente
    remove_column :decidim_homes_homes, :organizers

    # Adicionar a nova coluna com o tipo de dados desejado
    add_column :decidim_homes_homes, :organizers, :string, array: true, default: []
  end
end
