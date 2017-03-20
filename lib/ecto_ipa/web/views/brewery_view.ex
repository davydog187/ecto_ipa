defmodule EctoIpa.Web.BreweryView do
  use EctoIpa.Web, :view
  alias EctoIpa.Web.BreweryView

  def render("index.json", %{breweries: breweries}) do
    %{data: render_many(breweries, BreweryView, "brewery.json")}
  end

  def render("show.json", %{brewery: brewery}) do
    %{data: render_one(brewery, BreweryView, "brewery.json")}
  end

  def render("brewery.json", %{brewery: brewery}) do
    %{id: brewery.id,
      name: brewery.name,
      city: brewery.city,
      year_founded: brewery.year_founded}
  end
end
