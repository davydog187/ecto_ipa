defmodule EctoIpa.Web.BreweryController do
  use EctoIpa.Web, :controller

  alias EctoIpa.Bar
  alias EctoIpa.Bar.Brewery

  action_fallback EctoIpa.Web.FallbackController

  def index(conn, _params) do
    breweries = Bar.list_breweries()
    render(conn, "index.json", breweries: breweries)
  end

  def create(conn, %{"brewery" => brewery_params}) do
    with {:ok, %Brewery{} = brewery} <- Bar.create_brewery(brewery_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", brewery_path(conn, :show, brewery))
      |> render("show.json", brewery: brewery)
    end
  end

  def show(conn, %{"id" => id}) do
    brewery = Bar.get_brewery!(id)
    render(conn, "show.json", brewery: brewery)
  end

  def update(conn, %{"id" => id, "brewery" => brewery_params}) do
    brewery = Bar.get_brewery!(id)

    with {:ok, %Brewery{} = brewery} <- Bar.update_brewery(brewery, brewery_params) do
      render(conn, "show.json", brewery: brewery)
    end
  end

  def delete(conn, %{"id" => id}) do
    brewery = Bar.get_brewery!(id)
    with {:ok, %Brewery{}} <- Bar.delete_brewery(brewery) do
      send_resp(conn, :no_content, "")
    end
  end
end
