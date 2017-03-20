defmodule EctoIpa.Web.BreweryControllerTest do
  use EctoIpa.Web.ConnCase

  alias EctoIpa.Bar
  alias EctoIpa.Bar.Brewery

  @create_attrs %{city: "some city", name: "some name", year_founded: 42}
  @update_attrs %{city: "some updated city", name: "some updated name", year_founded: 43}
  @invalid_attrs %{city: nil, name: nil, year_founded: nil}

  def fixture(:brewery) do
    {:ok, brewery} = Bar.create_brewery(@create_attrs)
    brewery
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, brewery_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates brewery and renders brewery when data is valid", %{conn: conn} do
    conn = post conn, brewery_path(conn, :create), brewery: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, brewery_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "city" => "some city",
      "name" => "some name",
      "year_founded" => 42}
  end

  test "does not create brewery and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, brewery_path(conn, :create), brewery: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen brewery and renders brewery when data is valid", %{conn: conn} do
    %Brewery{id: id} = brewery = fixture(:brewery)
    conn = put conn, brewery_path(conn, :update, brewery), brewery: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, brewery_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "city" => "some updated city",
      "name" => "some updated name",
      "year_founded" => 43}
  end

  test "does not update chosen brewery and renders errors when data is invalid", %{conn: conn} do
    brewery = fixture(:brewery)
    conn = put conn, brewery_path(conn, :update, brewery), brewery: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen brewery", %{conn: conn} do
    brewery = fixture(:brewery)
    conn = delete conn, brewery_path(conn, :delete, brewery)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, brewery_path(conn, :show, brewery)
    end
  end
end
