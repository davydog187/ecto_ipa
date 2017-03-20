defmodule EctoIpa.Web.BeerStyleController do
  use EctoIpa.Web, :controller

  alias EctoIpa.Bar
  alias EctoIpa.Bar.BeerStyle

  action_fallback EctoIpa.Web.FallbackController

  def index(conn, _params) do
    beer_styles = Bar.list_beer_styles()
    render(conn, "index.json", beer_styles: beer_styles)
  end

  def create(conn, %{"beer_style" => beer_style_params}) do
    with {:ok, %BeerStyle{} = beer_style} <- Bar.create_beer_style(beer_style_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", beer_style_path(conn, :show, beer_style))
      |> render("show.json", beer_style: beer_style)
    end
  end

  def show(conn, %{"id" => id}) do
    beer_style = Bar.get_beer_style!(id)
    render(conn, "show.json", beer_style: beer_style)
  end

  def update(conn, %{"id" => id, "beer_style" => beer_style_params}) do
    beer_style = Bar.get_beer_style!(id)

    with {:ok, %BeerStyle{} = beer_style} <- Bar.update_beer_style(beer_style, beer_style_params) do
      render(conn, "show.json", beer_style: beer_style)
    end
  end

  def delete(conn, %{"id" => id}) do
    beer_style = Bar.get_beer_style!(id)
    with {:ok, %BeerStyle{}} <- Bar.delete_beer_style(beer_style) do
      send_resp(conn, :no_content, "")
    end
  end
end
