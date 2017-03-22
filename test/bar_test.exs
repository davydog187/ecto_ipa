defmodule EctoIpa.BarTest do
  use EctoIpa.DataCase

  alias EctoIpa.Bar
  alias EctoIpa.Bar.Brewery

  @create_attrs %{city: "some city", name: "some name", year_founded: 42}
  @update_attrs %{city: "some updated city", name: "some updated name", year_founded: 43}
  @invalid_attrs %{city: nil, name: nil, year_founded: nil}

  @style_attrs %{abv: 0.05, ibu: 10, name: "IPA"}

  def fixture(name, attrs \\ @create_attrs)
  def fixture(:brewery, attrs) do
    {:ok, brewery} = Bar.create_brewery(attrs)
    brewery
  end

  def fixture(:style, attrs) do
    {:ok, style} = Bar.create_beer_style(attrs)
    style
  end

  test "list_breweries/1 returns all breweries" do
    brewery = fixture(:brewery)
    assert Bar.list_breweries() == [brewery]
  end

  test "get_brewery! returns the brewery with given id" do
    brewery = fixture(:brewery)
    assert Bar.get_brewery!(brewery.id) == brewery
  end

  test "create_brewery/1 with valid data creates a brewery" do
    assert {:ok, %Brewery{} = brewery} = Bar.create_brewery(@create_attrs)
    assert brewery.city == "some city"
    assert brewery.name == "some name"
    assert brewery.year_founded == 42
  end

  test "create_brewery/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Bar.create_brewery(@invalid_attrs)
  end

  test "update_brewery/2 with valid data updates the brewery" do
    brewery = fixture(:brewery)
    assert {:ok, brewery} = Bar.update_brewery(brewery, @update_attrs)
    assert %Brewery{} = brewery
    assert brewery.city == "some updated city"
    assert brewery.name == "some updated name"
    assert brewery.year_founded == 43
  end

  test "update_brewery/2 with invalid data returns error changeset" do
    brewery = fixture(:brewery)
    assert {:error, %Ecto.Changeset{}} = Bar.update_brewery(brewery, @invalid_attrs)
    assert brewery == Bar.get_brewery!(brewery.id)
  end

  test "update_beer_style/2 with invalid data returns error changeset" do
    style = fixture(:style, @style_attrs)
    assert {:error, %Ecto.Changeset{valid?: false}} = Bar.update_beer_style(style, %{abv: 10, ibu: 4})
    assert style == Bar.get_beer_style!(style.id)
  end

  test "delete_brewery/1 deletes the brewery" do
    brewery = fixture(:brewery)
    assert {:ok, %Brewery{}} = Bar.delete_brewery(brewery)
    assert_raise Ecto.NoResultsError, fn -> Bar.get_brewery!(brewery.id) end
  end

  test "change_brewery/1 returns a brewery changeset" do
    brewery = fixture(:brewery)
    assert %Ecto.Changeset{} = Bar.change_brewery(brewery)
  end
end
