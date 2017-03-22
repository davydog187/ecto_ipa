defmodule EctoIpa.Web.Router do
  use EctoIpa.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EctoIpa.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", EctoIpa.Web do
    pipe_through :api

    resources "/breweries", BreweryController, except: [:new, :edit]
    resources "/beer_styles", BeerStyleController, except: [:new, :edit]
  end
end
