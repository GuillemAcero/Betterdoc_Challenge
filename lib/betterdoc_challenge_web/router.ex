defmodule BetterdocChallengeWeb.Router do
  use BetterdocChallengeWeb, :router

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

  scope "/", BetterdocChallengeWeb do
    pipe_through :browser

    get "/", CaseController, :index

    scope "/cases" do
      get("/", CaseController, :index)
      get("/:id", CaseController, :show)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BetterdocChallengeWeb do
  #   pipe_through :api
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BetterdocChallengeWeb.Telemetry
    end
  end
end
