# Componente Homes

The Homes module adds static home capabilities to any participatory process. It basically provides an interface to include arbitrary HTML content to any step.

## Usage

Homes will be available as a Component for a Participatory Process.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decidim-homes'
```

And then execute:

```bash
bundle
```

## Como adicionar um atributo

Para exemplificar vamos trabalhar com um atributo `inteiro`, com o nome `exemplo`.

### 1. Model

#### caminho: `app/models/decidim/homes/home.rb`

```rb
module Decidim
  module Homes
    class Home < Homes::ApplicationRecord
      # ......
      
      attribute :exemplo, :integer
      
      # ......
    end
  end
end
```

### 2. Forms

#### caminho: `app/forms/decidim/homes/admin/home.rb`

```rb
module Decidim
  module Homes
    module Admin
      # This class holds a Form to update homes from Decidim's admin panel.
      class HomeForm < Decidim::Form
        # ......

        attribute :exemplo, Integer
        
        # ......
      end
    end
  end
end
```

### 3. Commands

Para o commands temos que adicionar em **2 arquivos**:

#### caminho: `app/commands/decidim/homes/admin/update_home.rb`

```rb
module Decidim
  module Homes
    module Admin
      class UpdateHome < Decidim::Command
        # ......

        def update_home
          Decidim.traceability.update!(
            # .... outros atributos
            exemplo: @form.exemplo
          )
        end

        # ......
      end
    end
  end
end
```

#### caminho: `app/commands/decidim/homes/copy_home.rb`

```rb
module Decidim
  module Homes
    module Admin
      class CopyHome < Decidim::Command
        # ......

        def call
        Decidim::Homes::Home.transaction do
          homes = Decidim::Homes::Home.where(component: @context[:old_component])
          homes.each do |home|
            Decidim::Homes::Home.create!(
              # .... outros atributos
              exemplo: home.exemplo,         
            )
          end
        end
        broadcast(:ok)
      rescue ActiveRecord::RecordInvalid
        broadcast(:invalid)
      end

        # ......
      end
    end
  end
end
```

### 4. Serializer

### 5. Migrate

Caso voce ainda não tenha criado o banco, voce pode adicionar diretamente no arquivo de criação:

#### caminho: `db/migrate/20020711110601_create_decidim_homes.rb`

```rb
class CreateDecidimHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_homes_homes do |t|
      # .... outros atributos
      t.integer :exemplo
      
      t.timestamps
    end
  end
end
```

Mas caso o seu banco ja tenha sido criado, você precisa criar um arquivo de modificação:

Dentro do diretório `Homes` execute o seguinte comando:

```bash
rails g migration AddExemploToHomes exemplo:integer
```

Deve-se esperar o seguinte código:

#### caminho: `db/migrates/XXXXXXXXXXXXXX_add_exemplo_to_homes.rb`

```rb
class AddExemploToHomes < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_homes_homes, :exemplo, :integer
  end
end
```

### 6. View


