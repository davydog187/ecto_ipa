defmodule EctoIpa.Repo.Migrations.CreateEctoIpa.Bar.BeerStyle do
  use Ecto.Migration

  def change do
    create table(:bar_beer_styles) do
      add :name, :string
      add :ibu, :integer
      add :abv, :float

      timestamps()
    end

  end
end
