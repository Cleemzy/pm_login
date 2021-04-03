defmodule PmLoginWeb.Router do
  use PmLoginWeb, :router

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

  scope "/", PmLoginWeb do
    pipe_through :browser

    resources "/rights", RightController

    resources "/users", UserController

    get "/users/:id/edit_profile", UserController, :edit_profile

    get "/list_users", UserController, :list

    put "/profile/:id", UserController, :update_profile

    patch "/profile/:id", UserController, :update_profile

    put "/user/:id", UserController, :archive

    patch "/user/:id", UserController, :archive

    put "/user/restore/:id", UserController, :restore

    get "/", PageController, :index

    post "/auth", AuthController, :auth

    post "/test_auth", AuthController, :test_auth

    get "/signout", AuthController, :sign_out
  end

  # Other scopes may use custom stacks.
  # scope "/api", PmLoginWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PmLoginWeb.Telemetry
    end
  end
end
