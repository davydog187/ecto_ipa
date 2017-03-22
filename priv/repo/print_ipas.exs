alias EctoIpa.Bar.BeerStyle
alias EctoIpa.Repo

import Ecto.Query

ipa =
  BeerStyle
  |> where(name: "India pale ale")
  |> preload(:breweries)
  |> Repo.one()

for brewery <- ipa.breweries, do: IO.puts brewery.name
