defmodule Backend.Web.Router do
  use Backend.Web, :router

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

  scope "/", Backend.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/charge", PageController, :charge
  end

  # Other scopes may use custom stacks.
  # scope "/api", Backend.Web do
  #   pipe_through :api
  # end
end