defmodule EctoIpa.Bar.BeerStyle do
  use Ecto.Schema

  schema "bar_beer_styles" do
    field :abv, :float
    field :ibu, :integer
    field :name, :string

    timestamps()
  end
end
