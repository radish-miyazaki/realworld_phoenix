defmodule RealworldPhoenixWeb.Router do
  alias RealworldPhoenixWeb.ArticleLive
  use RealworldPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RealworldPhoenixWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RealworldPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/articles", ArticleLive.Index, :index
    live "/articles/new", ArticleLive.Index, :new
    live "/articles/:id/edit", ArticleLive.Index, :edit
    live "/articles/:id", ArticleLive.Index, :show
    live "/articles/:id/show/edit", ArticleLive.Show, :edit
  end

  if Application.compile_env(:realworld_phoenix, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RealworldPhoenixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
