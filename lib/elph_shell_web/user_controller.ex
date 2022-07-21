defmodule ElphShellWeb.UserController do
  use ElphShellWeb, :controller

  alias ElphShell.Coherence.Schemas
  alias ElphShell.Coherence.User

  action_fallback ElphShellWeb.FallbackController

  def index(conn, _params) do
    users = Schemas.list_user()

    %{assigns: %{current_user: %{id: current_user_id}}} = conn

    conn
    |> render("index.json", users: users, current_user_id: current_user_id)
  end

  def show(conn, %{"id" => id}) do
    user = Schemas.get_user!(id)

    %{assigns: %{current_user: %{id: current_user_id}}} = conn

    conn
    |> render("show.json", user: user, current_user_id: current_user_id)
  end

  def create(conn, %{"user" => params}) do
    with {:ok, %{} = user} <- Schemas.create_user(params) do
      %{assigns: %{current_user: %{id: current_user_id}}} = conn

      conn
      |> render("show.json", user: user, current_user_id: current_user_id)
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    old_user = Schemas.get_user!(id)

    with {:ok, %{} = user} <- Schemas.update_user(old_user, params) do
      %{assigns: %{current_user: %{id: current_user_id}}} = conn

      conn
      |> render("show.json", user: user, current_user_id: current_user_id)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Schemas.get_user!(id)

    with {:ok, %User{}} <- Schemas.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
