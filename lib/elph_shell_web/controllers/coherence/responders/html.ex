defmodule Coherence.Responders.Html do
  @moduledoc """
  This module defines the responses sent to the user after user management actions
  carried out within the browser. This are only the use-cases that do non-standard
  behaviour compared to coherence. Those can be found in Coherence.Responders.Html
  """
  use Responders.Html

  import Phoenix.Controller, only: [render: 3, put_flash: 3]

  def invitation_create_user_success(conn, %{}) do
    conn
    |> render("created.html", %{})
  end

  def password_create_success(conn, %{info: info}) do
    conn
    |> put_flash(:info, info)
    |> render("empty.html", %{})
  end

  def password_update_success(conn, %{info: info}) do
    conn
    |> put_flash(:info, info)
    |> render("empty.html", %{})
  end

  def password_update_error(conn, %{error: error}) do
    conn
    |> put_flash(:error, error)
    |> render("empty.html", %{})
  end

  def password_update_error(conn, %{changeset: changeset}) do
    conn
    |> render("edit.html", changeset: changeset)
  end
end
