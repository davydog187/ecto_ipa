# A Tour of Ecto

## Topics

* Changesets
* Schemas
    * Database backed schemas
    * Embedded schemas
* Ecto.Query
    * Expressiveness
    * Schemaless

## Foreward

As of today (3/22/17), I have been writing Elixir professionally for 6 months for https://theoutline.com. In this 6 months I have become increasingly excited about the capabilities of Elixir and the robustness of the ecosystem. As a programmer who builds for the web, you will often find yourself in need of persisting various forms of data to a database. Today I would like to speak about Ecto, a fantastic Elixir library that provides excellent primitives for interacting with data and databases.

Ecto is two libraries, a data validation library (Changesets), and a database abstraction for fetching and storing data (pretty much everything else). When I began working with Phoenix, I found Ecto to have the largest learning curve. After overcoming this curve, I have found Ecto to be **the** most powerful tool in my Elixir toolbelt. Today I would like to introduce you to the most important concepts in Ecto for you to become dangerous.

### What will we learn today?
* Changesets - The data validation portion of Ecto
* Migrations and Schemas - Creating and modeling database tables in Ecto
* Ecto.Query - A super expressive abstraction over SQL that gives you several ways to interact with your data
* Ecto without a DB - How `embedded_schemas` and `Changeset`s make Ecto a good choice even when you don't have a database

### What will we not go over?
* Ecto.Multi
* Transactions
* Adapters (Databases other than Postgres or MySQL)
* Ecto Custom Types

The best way to learn something new is to dive into writing code. Today I'd like to show you some concrete examples that you can follow along with. 

Its also worth noting that one best features of Elixir is its first class documentation, and Ecto is no exception. When in doubt, [read the docs](https://hexdocs.pm/ecto/Ecto.html). They are not only your friend, but an extensive learning tool. If you're really struggling to understand a bit of code, or curious how something works, reach for the docs first. They will often provide working examples, as well as links back to the source code.

### Working Example - EctoIPA 
Today we will be thinking in terms of :beer:, specifically breweries, and the styles of beer that they brew. We are going to keep our example as simple as possible, using two tables.

[Beer Styles](https://github.com/davydog187/ecto_ipa/blob/master/lib/ecto_ipa/bar/beer_style.ex) are the first table. They consist of a name (e.g. Pilsener), an abv (Alchohol By Volume) value, ranging between 0 and .20, and IBU (International Bitterness Unit) between 5 and 120.

```elixir
field :abv, :float
field :ibu, :integer
field :name, :string
```

[Breweries](https://github.com/davydog187/ecto_ipa/blob/master/lib/ecto_ipa/bar/brewery.ex) will have a city, name, and the year founded. They will also be associated with a random number of beer styles.
```elixir
 field :city, :string
 field :name, :string
 field :year_founded, :integer
```

**Data Disclaimer**
I'd also like to mention that the data we're playing with today is mostly fake. It uses real New York brewery names, but associates them with beer styles that they may or may not brew. Sorry New York breweries.


## Changesets

The Changeset is the data validation portion of Ecto. It is both a datastructure, and a suite of functions that help you verify external input. Lets start with 


## Schemas

## The beauty of Ecto.Query
