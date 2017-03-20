defmodule EctoIpa.Repo.Migrations.CreateEctoIpa.Bar.Brewery do
  use Ecto.Migration

  def change do
    create table(:bar_breweries) do
      add :name, :string
      add :city, :string
      add :year_founded, :integer

      timestamps()
    end

  end
end
