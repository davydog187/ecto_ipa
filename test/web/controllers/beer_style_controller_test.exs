defmodule EctoIpa.Web.BeerStyleControllerTest do
  use EctoIpa.Web.ConnCase

  alias EctoIpa.Bar
  alias EctoIpa.Bar.BeerStyle

  @create_attrs %{abv: "0.05", ibu: 42, name: "some name"}
  @update_attrs %{abv: "0.062", ibu: 43, name: "some updated name"}
  @invalid_attrs %{abv: nil, ibu: nil, name: nil}

  def fixture(:beer_style, opts \\ %{}) do
    {:ok, beer_style} = Bar.create_beer_style(Map.merge(@create_attrs, opts))
    beer_style
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, beer_style_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates beer_style and renders beer_style when data is valid", %{conn: conn} do
    conn = post conn, beer_style_path(conn, :create), beer_style: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, beer_style_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "abv" => 0.05,
      "ibu" => 42,
      "name" => "some name"}
  end

  test "does not create beer_style and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, beer_style_path(conn, :create), beer_style: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen beer_style and renders beer_style when data is valid", %{conn: conn} do
    %BeerStyle{id: id} = beer_style = fixture(:beer_style)
    conn = put conn, beer_style_path(conn, :update, beer_style), beer_style: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, beer_style_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "abv" => 0.062,
      "ibu" => 43,
      "name" => "some updated name"}
  end

  test "does not update chosen beer_style and renders errors when data is invalid", %{conn: conn} do
    beer_style = fixture(:beer_style)
    conn = put conn, beer_style_path(conn, :update, beer_style), beer_style: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "validates the ranges for abv and ibu", %{conn: conn} do
    beer_style = fixture(:beer_style)
    conn = put conn, beer_style_path(conn, :update, beer_style), beer_style: %{abv: 10, ibu: 4}

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen beer_style", %{conn: conn} do
    beer_style = fixture(:beer_style)
    conn = delete conn, beer_style_path(conn, :delete, beer_style)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, beer_style_path(conn, :show, beer_style)
    end
  end
end
