defmodule EctoIpa.Bar.BeerStyle do
  use Ecto.Schema

  schema "bar_beer_styles" do
    field :name, :string
    field :abv, :float
    field :ibu, :integer

    timestamps()
  end

end
