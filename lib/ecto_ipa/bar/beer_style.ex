defmodule EctoIpa.Bar.BeerStyle do
  use Ecto.Schema

  alias EctoIpa.Bar.Brewery

  schema "bar_beer_styles" do
    field :name, :string
    field :abv, :float
    field :ibu, :integer

    many_to_many :breweries, Brewery, join_through: "brewery_styles"

    timestamps()
  end

end
