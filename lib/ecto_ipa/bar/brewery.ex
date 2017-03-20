defmodule EctoIpa.Bar.Brewery do
  use Ecto.Schema

  schema "bar_breweries" do
    field :city, :string
    field :name, :string
    field :year_founded, :integer

    timestamps()
  end
end
