defmodule PhraserMasterWeb.Router do
  use PhraserMasterWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PhraserMasterWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/slack", PhraserMasterWeb do
    pipe_through(:api)

    post("/phraser", PhraserController, :show)
    post("/setphraser", PhraserController, :create)
  end
end
