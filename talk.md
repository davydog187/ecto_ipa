# A Tour of Ecto

## Topics

* Database backed schemas  
* Changesets 
* Ecto.Query
* Embedded schemas

## Foreward

As of today (3/22/17), I have been writing Elixir professionally for 6 months for https://theoutline.com. In this 6 months I have become increasingly excited about the capabilities of Elixir and the robustness of the ecosystem. As a programmer who builds for the web, you will often find yourself in need of persisting various forms of data to a database. Today I would like to speak about Ecto, a fantastic Elixir library that provides excellent primitives for interacting with data and databases.

Ecto is two libraries, a data validation library (Changesets), and a database abstraction for fetching and storing data (pretty much everything else). When I began working with Phoenix, I found Ecto to have the largest learning curve. After overcoming this curve, I have found Ecto to be **the** most powerful tool in my Elixir toolbelt. Today I would like to introduce you to the most important concepts in Ecto for you to become dangerous.

### Prior Art
It is also worth noting where Ecto draws inspiration from. Those who are familar with [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord) in the Ruby on Rails world will feel pretty comfortable moving to Ecto. José Valim, the creator of Elixir, and longtime major Rails contributor, is by far the largest contributor to Ecto. Many of the shortcomings in ActiveRecord have been taken as lessons learned by José and team, and this wisdom helps make Ecto an incredible tool to work with.

### What will we learn today?
* Changesets - The data validation portion of Ecto
* Migrations and Schemas - Creating and modeling database tables in Ecto
* Ecto.Query - A super expressive abstraction over SQL that gives you several ways to interact with your data
* Ecto without a DB - How `embedded_schemas` and `Changeset`s make Ecto a good choice even when you don't have a database

### What will we **not** go over?
* Ecto.Multi
* Transactions
* Adapters (Databases other than Postgres or MySQL)
* Ecto Custom Types
* ...and more

The best way to learn something new is to dive into writing code. Today I'd like to show you some concrete examples that you can follow along with. 

Its also worth noting that one best features of Elixir is its first class documentation, and Ecto is no exception. When in doubt, [read the docs](https://hexdocs.pm/ecto/Ecto.html). They are not only your friend, but an extensive learning tool. If you're really struggling to understand a bit of code, or curious how something works, reach for the docs first. They will often provide working examples, as well as links back to the source code.

## Assumptions
* You understand the basics of a database (Postgres for our example)
* You are familiar at a high level with Elixir syntax

## Todays Example - EctoIPA 
Today we will be thinking in terms of :beer:, specifically breweries, and the styles of beer that they brew. We are going to keep our example as simple as possible, using two tables to describe breweries, and the styles of beer that they brew.

**Data Disclaimer**
I'd also like to mention that the data we're playing with today is mostly fake. It uses real New York brewery names, but associates them with beer styles that they may or may not brew. Sorry New York breweries 🙃.

[Beer Styles](https://github.com/davydog187/ecto_ipa/blob/master/lib/ecto_ipa/bar/beer_style.ex) are the first table. They consist of a name (e.g. Pilsener), an abv (Alchohol By Volume) value, ranging between 0 and .20, and IBU (International Bitterness Unit) between 5 and 120.

```elixir
field :abv, :float
field :ibu, :integer
field :name, :string

many_to_many :breweries, Brewery, join_through: "brewery_styles"
```

[Breweries](https://github.com/davydog187/ecto_ipa/blob/master/lib/ecto_ipa/bar/brewery.ex) will have a city, name, and the year founded. They will also be associated with a random number of beer styles.
```elixir
field :city, :string
field :name, :string
field :year_founded, :integer

many_to_many :beer_styles, BeerStyle, join_through: "brewery_styles"
```

## Schemas

The above are snapshots of what Ecto calls a Schema. A schema is two things, a struct consisting of fields, types, and other metadata, and the database table that they map back to. 

```elixir
defmodule EctoIpa.Bar.BeerStyle do
  use Ecto.Schema

  alias EctoIpa.Bar.Brewery

  schema "bar_beer_styles" do
    field :name, :string
    field :abv, :float
    field :ibu, :integer

    many_to_many :breweries, Brewery, join_through: "brewery_styles"

    timestamps()
  end

end
```

This schema defines 4 fields, which behind the scenes will call `defstruct`, and define a structure for you to work with. It also specifies the database table that it maps back to `schema "bar_beer_styles"`. 

## Migrations

In order to create the underlying database tables, we need to write an ecto migration. Ecto provides 


## Changesets

The Changeset is the data validation portion of Ecto. It is both a datastructure, and a suite of functions that help you verify external input. 

Lets start with the example of a `BeerStyle`. Besides its relationship to a `Brewery`, it has three pieces of metadata, name, abv, and ibu, each with their own constraints. Changesets are useful for when we want to create or update a `BeerStyle`. For our example, we have a json api that lets you create and update beer styles. 

```elixir
def create_beer_style(attrs \\ %{}) do
   %BeerStyle{}
   |> beer_style_changeset(attrs)
   |> Repo.insert()
end
```

In the above, `attrs` may have extra keys, break constraints, or miss required fields. If we run this data through a Changeset, we can safely confirm if it is a valid or invalid changeset.

```elixir
defp beer_style_changeset(%BeerStyle{} = beer_style, attrs) do
  beer_style
  |> cast(attrs, [:name, :ibu, :abv])
  |> validate_required([:name, :ibu, :abv])
  |> validate_inclusion(:ibu, 5..120)
  |> validate_number(:abv, less_than_or_equal_to: 0.20, greater_than: 0)
end
```

Lets break this down line by line.

```elixir
cast(beer_style, attrs, [:name, :ibu, :abv])
```

First, we take a `%BeerStyle{}`, and the input parameters from our user, `attrs`, and convert `name`, `ibu`, and `abv` to atom keys.

```elixir
%{
  "name" => "New Valid Style",
  "ibu" => 10,
  "abv" => 0.09,
  "this_will_be_ignored" => true
}
```

This would pass the next three lines of validation

```elixir
changeset
|> validate_required([:name, :ibu, :abv])
|> validate_inclusion(:ibu, 5..120)
|> validate_number(:abv, less_than_or_equal_to: 0.20, greater_than: 0)
```

It has all three required fields, and ibu and abv are within the specified ranges. The return value of this function match on a `%Ecto.Changeset{valid?: true}`

However, if the user omitted one of the required fields, like name, we would see an error like so

```elixir
{:error, #Ecto.Changeset<action: :insert, changes: %{abv: 0.09, ibu: 10}, errors: [name: {"can't be blank", [validation: :required]}], data: #EctoIpa.Bar.BeerStyle<>, valid?: false>}
```

Or if we tried to update abv or ibu outside of the validated rangers

```elixir
{:error,
   #Ecto.Changeset<action: :update, changes: %{abv: 10.0, ibu: 4},
      errors: [abv: {"must be less than or equal to %{number}", [validation: :number, number: 0.2]},
              ibu: {"is invalid", [validation: :inclusion]}],
              data: #EctoIpa.Bar.BeerStyle<>, valid?: false>}
```

## The beauty of Ecto.Query

So far we've only talked about creating and updating data in your database. Now I'd like to talk about the robustness of `Ecto.Query`, and its amazing flexibility. 

Ecto queries have struck an incredible balance. They are a near perfect DSL for SQL that really reads and writes like its underlying SQL representation. Take the following example

```elixir
from s in "bar_beer_styles", where: s.abv > 0.10, select: s.name
```

This is ~roughly~ equilavent to the Postgres SQL

```sql
SELECT b0."name" FROM "bar_beer_styles" AS b0 WHERE (b0."abv" > 0.1::float)
```

This is great if you're coming from another language, and already familiar with SQL. What if you're not? Thats where Ecto's beauty comes in. Ecto allows you to functionally compose query functions, so you can write your queries just how you would write some other kind of data transformation

```elixir
BeerStyle
|> where([s], s.abv > 0.10)
|> select([s], s.name)
```

This will return effectively the same code. Its also interesting to point out the above queries are "schemaless". Because we specified a select statement that pulls out an individual field, we will only get a list of style names back like so

```elixir
["Altbier", "Amber ale", "Barley wine", "American Barleywine",
 "Berliner Weisse", "Best Bitter", "Blonde Ale", "Bock", "Brown ale",
 "Cream Ale", "Doppelbock", "Dunkel", "European-Style Dark Lager",
 "Dunkelweizen", "Eisbock", "Flanders red ale", "Golden/Summer ale",
 "Golden Ale", "Gose", "Gueuze", "Hefeweizen", "Helles", "India pale ale",
 "American-Style India Pale Ale", "Session India Pale Ale", "Imperial",
 "English IPA", "American IPA", "Specialty IPA", "Double IPA", "Kölsch",
 "Lambic", "Fruit Lambic", "Light ale", ...]
```

If we would like to get a list of `BeerStyle`s back, you can either omit the select part of the statement to get the entire struct back, or specify which `BeerStyle` fields you would like using `select([:name, :abv])`. The prior example would not pull `ibu` out of the database, but will decode it into a struct for you.

## Embedded Schemas
