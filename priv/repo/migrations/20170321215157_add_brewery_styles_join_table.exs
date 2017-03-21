defmodule EctoIpa.Repo.Migrations.AddBreweryStylesJoinTable do
  use Ecto.Migration

  def change do
    create table(:brewery_styles, primary_key: false) do
      add :brewery_id, references(:bar_breweries)
      add :beer_style_id, references(:bar_beer_styles)
    end
  end
end
