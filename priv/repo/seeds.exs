breweries =
  [{"Abandon Brewing Company", "Penn Yan", 2013},
   {"Adirondack Brewery", "Lake George", 1999},
   {"Barrage Brewing Company", "Farmingdale", 2014},
   {"Barrier Brewing Company", "Oceanside", 2010},
   {"Big Alice Brewing", "Long Island City, Queens", 2013},
   {"Blue Point Brewing Company", "Patchogue", 2014},
   {"Brewery Ommegang", "Cooperstown", 2003},
   {"Bridge and Tunnel Brewery", "Maspeth, Queens", 2012},
   {"Bronx Brewery", "The Bronx", 2014},
   {"Brooklyn Brewery", "Williamsburg, Brooklyn", 1988},
   {"Captain Lawrence Brewing Company", "Pleasantville", 2006},
   {"Chelsea Craft Brewing Company", "Chelsea, Manhattan", 1995},
   {"Coney Island Brewing Company", "Coney Island, Brooklyn", 2007},
   {"Crooked Ladder Brewing Company", "Riverhead", 2013},
   {"Dundee Brewing Company", "Rochester", 1994},
   {"Empire Brewing Company", "Syracuse", 1994},
   {"Finback Brewery", "Ridgewood, Queens", 2014},
   {"Flagship Brewing Company", "Staten Island", 2014},
   {"Flying Bison Brewing Company", "Buffalo", 2000},
   {"Genesee Brewing Company", "Rochester", 1878},
   {"Great South Bay Brewery", "Bay Shore", 2009},
   {"Greenpoint Beer & Ale Company", "Greenpoint, Brooklyn", 2014},
   {"Gun Hill Brewing Company", "The Bronx", 2014},
   {"Industrial Arts Brewing Company", "Garnerville", 2016},
   {"Keegan Ales", "Kingston", 2003},
   {"Keg & Lantern Brewing Company", "Greenpoint, Brooklyn", 2014},
   {"Kuka Andean Brewing Company", "Blauvelt", 2010},
   {"LIC Beer Project", "Long Island City, Queens", 2015},
   {"Long Ireland Beer Company", "Riverhead", 2011},
   {"Matt Brewing Company", "Utica", 1888},
   {"Other Half Brewing Company", "Carroll Gardens, Brooklyn", 2014},
   {"Rockaway Brewing Company", "Long Island City", 2011},
   {"Rohrbach Brewing Company", "Rochester", 1991},
   {"Shmaltz Brewing Company", "Clifton Park", 1996},
   {"SingleCut Beersmiths", "Astoria, Queens", 2012},
   {"Sixpoint Brewery", "Red Hook, Brooklyn", 2004},
   {"Southern Tier Brewing Company", "Lakewood", 2002},
   {"Strong Rope Brewery", "Gowanus, Brooklyn", 2015},
   {"Threes Brewing", "Gowanus, Brooklyn", 2014},
   {"Transmitter Brewing", "Queens", 2014},
   {"Upstate Brewing Company", "Elmira", 2012},
   {"War Horse Brewing Company", "Geneva", 2008}
  ]

styles =
  [
    "Altbier",
    "Amber ale",
    "Barley wine",
    "American Barleywine",
    "Berliner Weisse",
    "Best Bitter",
    "Blonde Ale",
    "Bock",
    "Brown ale",
    "Cream Ale",
    "Doppelbock",
    "Dunkel",
    "European-Style Dark Lager",
    "Dunkelweizen",
    "Eisbock",
    "Flanders red ale",
    "Golden/Summer ale",
    "Golden Ale",
    "Gose",
    "Gueuze",
    "Hefeweizen",
    "Helles",
    "India pale ale",
    "American-Style India Pale Ale",
    "Session India Pale Ale",
    "Imperial",
    "English IPA",
    "American IPA",
    "Specialty IPA",
    "Double IPA",
    "Kölsch",
    "Lambic",
    "Fruit Lambic",
    "Light ale",
    "Malt liquor",
    "English-Style Dark Mild Ale",
    "Oktoberfestbier",
    "Märzen",
    "Old ale",
    "Pale ale",
    "American-Style Pale Ale",
    "American-Style Strong Pale Ale",
    "Belgian-Style Pale Ale",
    "Australian-Style Pale Ale",
    "International-Style Pale Ale",
    "Belgian Pale Ale",
    "Pilsener",
    "Bohemian-Style Pilsener",
    "American-Style Pilsener",
    "Czech Pale Lager",
    "Czech Premium Pale Lager",
    "German Pils",
    "Porter",
    "Robust Porter",
    "American-Style Imperial Porter",
    "Smoke Porter",
    "Baltic-Style Porter",
    "English Porter",
    "American Porter",
    "Pre-Prohibition Porter (Historical)",
    "Red ale",
    "American-Style Amber/Red Ale",
    "Double Red Ale",
    "Imperial Red Ale",
    "Roggenbier",
    "Saison",
    "Specialty Saison",
    "Scotch ale",
    "Stout",
    "Dry Stout",
    "Imperial Stout",
    "Oatmeal Stout",
    "British-Style Imperial Stout",
    "Classic Irish-Style Dry Stout",
    "Export-Style Stout",
    "American-Style Stout",
    "American-Style Imperial Stout",
    "Irish Extra Stout",
    "Sweet Stout",
    "Oatmeal Stout",
    "Tropical Stout",
    "Foreign Extra Stout",
    "American Stout",
    "Imperial Stout",
    "Schwarzbier",
    "Vienna lager",
    "Witbier",
    "Weissbier",
    "German-Style Leichtes Weizen",
    "South German-Style Bernsteinfarbenes Weizen",
    "Weizenbock",
  ]

alias EctoIpa.{Bar, Repo, SeedData}

abv_values = Enum.map(5..20, fn num -> num / 1 end)
ibu_values = 5..120

styles =
  Enum.map(styles, fn style ->
    %Bar.BeerStyle{
      name: style,
      abv: Enum.random(abv_values),
      ibu: Enum.random(ibu_values)
    }
    |> Repo.insert!()
    |> Repo.preload(:breweries)
  end)

num_styles = length(styles)
random_range = 1..num_styles

for {name, city, year} <- breweries do
  brewery =
    %Bar.Brewery{
      name: name,
      city: city,
      year_founded: year
    }
    |> Repo.insert!()
    |> Repo.preload(:beer_styles)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:beer_styles, Enum.take_random(styles, Enum.random(random_range)))
    |> Repo.update!()
end
