defmodule EctoIpa.Bar.Brewery do
  use Ecto.Schema

  alias EctoIpa.Bar.BeerStyle

  schema "bar_breweries" do
    field :name, :string
    field :city, :string
    field :year_founded, :integer

    many_to_many :beer_styles, BeerStyle, join_through: "brewery_styles"

    timestamps()
  end
end
