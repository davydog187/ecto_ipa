# A Tour of Ecto

## Topics

* Changesets
* Schemas
    * Database backed schemas
    * Embedded schemas
* Ecto.Query
    * Expressiveness
    * Schemaless

### Foreward

Ecto is two libraries, a data validation library (Changesets), and a database abstraction for fetching and storing data (pretty much everything else). When I began working with Phoenix, I found Ecto to have the largest learning curve. After overcoming this curve, I have found Ecto to be **the** most powerful tool in my Elixir belt. Today I would like to introduce you to the most important concepts in Ecto for you to become dangerous.

What will we learn today?
* Changesets - The data validation portion of Ecto
* Migrations and Schemas - Creating and modeling database tables in Ecto
* Ecto.Query - A super expressive abstraction over SQL that gives you several ways to interact with your data
* Ecto without a DB - How `embedded_schemas` and `Changeset`s make Ecto a good choice even when you don't have a database

What will we not go over?
* Ecto.Multi
* Transactions
* Adapters (Databases other than Postgres or MySQL)
* Ecto Custom Types


The best way to learn something new is to dive into writing code. Today I'd like to show you some concrete examples that you can follow along with. 

Its also worth noting that one best features of Elixir is its first class documentation, and Ecto is no exception. When in doubt, [read the docs](https://hexdocs.pm/ecto/Ecto.html). They are not only your friend, but an extensive learning tool. They will often provide working examples, as well as links back to the source code, if you're really struggling to understand a bit of code, or curious how something woorks.




### Changesets

The Changeset is the data validation portion of Ecto. It is both a datastructure, and a suite of functions that help you verify external input. Lets start with 


### Schemas

### The beauty of Ecto.Query
