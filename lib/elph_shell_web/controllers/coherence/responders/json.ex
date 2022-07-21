defmodule Coherence.Responders.Json do
  @moduledoc """
  This module defines the responses sent to the user after user management actions
  carried out through the api. This are only the use-cases that do non-standard
  behaviour compared to coherence. Those can be found in Coherence.Responders.Json
  """
  use Responders.Json

  def session_create_success(conn, _opts) do
    conn
    |> put_status(201)
    |> render(:session, auth_token: conn.assigns.auth_token)
  end
end
