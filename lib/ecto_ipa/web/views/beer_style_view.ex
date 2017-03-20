defmodule EctoIpa.Web.BeerStyleView do
  use EctoIpa.Web, :view
  alias EctoIpa.Web.BeerStyleView

  def render("index.json", %{beer_styles: beer_styles}) do
    %{data: render_many(beer_styles, BeerStyleView, "beer_style.json")}
  end

  def render("show.json", %{beer_style: beer_style}) do
    %{data: render_one(beer_style, BeerStyleView, "beer_style.json")}
  end

  def render("beer_style.json", %{beer_style: beer_style}) do
    %{id: beer_style.id,
      name: beer_style.name,
      ibu: beer_style.ibu,
      abv: beer_style.abv}
  end
end
