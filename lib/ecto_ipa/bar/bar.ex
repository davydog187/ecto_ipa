defmodule EctoIpa.Bar do
  @moduledoc """
  The boundary for the Bar system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias EctoIpa.Repo

  alias EctoIpa.Bar.Brewery

  @doc """
  Returns the list of breweries.

  ## Examples

      iex> list_breweries()
      [%Brewery{}, ...]

  """
  def list_breweries do
    Repo.all(Brewery)
  end

  @doc """
  Gets a single brewery.

  Raises `Ecto.NoResultsError` if the Brewery does not exist.

  ## Examples

      iex> get_brewery!(123)
      %Brewery{}

      iex> get_brewery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_brewery!(id), do: Repo.get!(Brewery, id)

  @doc """
  Creates a brewery.

  ## Examples

      iex> create_brewery(%{field: value})
      {:ok, %Brewery{}}

      iex> create_brewery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_brewery(attrs \\ %{}) do
    %Brewery{}
    |> brewery_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a brewery.

  ## Examples

      iex> update_brewery(brewery, %{field: new_value})
      {:ok, %Brewery{}}

      iex> update_brewery(brewery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_brewery(%Brewery{} = brewery, attrs) do
    brewery
    |> brewery_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Brewery.

  ## Examples

      iex> delete_brewery(brewery)
      {:ok, %Brewery{}}

      iex> delete_brewery(brewery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_brewery(%Brewery{} = brewery) do
    Repo.delete(brewery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking brewery changes.

  ## Examples

      iex> change_brewery(brewery)
      %Ecto.Changeset{source: %Brewery{}}

  """
  def change_brewery(%Brewery{} = brewery) do
    brewery_changeset(brewery, %{})
  end

  defp brewery_changeset(%Brewery{} = brewery, attrs) do
    brewery
    |> cast(attrs, [:name, :city, :year_founded])
    |> validate_required([:name, :city, :year_founded])
  end

  alias EctoIpa.Bar.BeerStyle

  @doc """
  Returns the list of beer_styles.

  ## Examples

      iex> list_beer_styles()
      [%BeerStyle{}, ...]

  """
  def list_beer_styles do
    Repo.all(BeerStyle)
  end

  @doc """
  Gets a single beer_style.

  Raises `Ecto.NoResultsError` if the Beer style does not exist.

  ## Examples

      iex> get_beer_style!(123)
      %BeerStyle{}

      iex> get_beer_style!(456)
      ** (Ecto.NoResultsError)

  """
  def get_beer_style!(id), do: Repo.get!(BeerStyle, id)

  @doc """
  Creates a beer_style.

  ## Examples

      iex> create_beer_style(%{field: value})
      {:ok, %BeerStyle{}}

      iex> create_beer_style(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_beer_style(attrs \\ %{}) do
    %BeerStyle{}
    |> beer_style_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a beer_style.

  ## Examples

      iex> update_beer_style(beer_style, %{field: new_value})
      {:ok, %BeerStyle{}}

      iex> update_beer_style(beer_style, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_beer_style(%BeerStyle{} = beer_style, attrs) do
    beer_style
    |> beer_style_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BeerStyle.

  ## Examples

      iex> delete_beer_style(beer_style)
      {:ok, %BeerStyle{}}

      iex> delete_beer_style(beer_style)
      {:error, %Ecto.Changeset{}}

  """
  def delete_beer_style(%BeerStyle{} = beer_style) do
    Repo.delete(beer_style)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking beer_style changes.

  ## Examples

      iex> change_beer_style(beer_style)
      %Ecto.Changeset{source: %BeerStyle{}}

  """
  def change_beer_style(%BeerStyle{} = beer_style) do
    beer_style_changeset(beer_style, %{})
  end

  defp beer_style_changeset(%BeerStyle{} = beer_style, attrs) do
    beer_style
    |> cast(attrs, [:name, :ibu, :abv])
    |> validate_required([:name, :ibu, :abv])
  end
end
