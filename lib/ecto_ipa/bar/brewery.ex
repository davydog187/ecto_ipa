defmodule EctoIpa.Bar.Brewery do
  use Ecto.Schema

  schema "bar_breweries" do
    field :name, :string
    field :city, :string
    field :year_founded, :integer

    timestamps()
  end
end
