defmodule ElphShellWeb.Router do
  use ElphShellWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api_public do
    plug(:accepts, ["json"])
  end

  pipeline :api_coherence do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:fetch_flash)
  end

  pipeline :api_admin do
    plug(:accepts, ["json"])

    plug(Coherence.Authentication.Token,
      source: :header,
      param: "x-auth-token",
      error: &__MODULE__.auth_error_json/1
    )
  end

  def auth_error_json(conn) do
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(401, ~s'{"error":"authentication required"}')
  end

  ### PUBLIC BROWSER ###

  scope "/users", Coherence do
    pipe_through(:browser)

    resources("/passwords", PasswordController, only: [:edit, :update])
  end

  ### ADMIN API ###

  scope "/api/admin" do
    pipe_through(:api_admin)

    scope "/", ElphShellWeb do
      resources("/users", UserController, only: [:index, :show, :create, :update, :delete])
    end

    scope "/", ElphWeb do
      resources("/contents", ContentController, only: [:create, :index, :show, :delete])
      resources("/media", MediaController, only: [:create])
    end
  end

  ### PUBLIC API ###

  scope "/api" do
    pipe_through(:api_public)

    scope "/", ElphShellWeb do
      get("/static/:slug", StaticPageController, :show)
    end
  end

  scope "/api", Coherence do
    pipe_through(:api_coherence)

    # login
    resources("/sessions", SessionController, only: [:create])

    # password reset
    resources("/passwords", PasswordController, only: [:create])
  end
end
