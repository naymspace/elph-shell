defmodule ElphShellWeb.Coherence.TokenAuth do
  @moduledoc """
  This module handles the custom session creation with a token. Coherence by default has
  something similar for cookie-authentication, but not for tokens. I.E. by default you
  can't "log in" and get a token back, that can be used to authenticate you for future
  requests. This module is plugged into the default session-create flow via config.exs.
  """
  import Plug.Conn

  alias Coherence.Authentication.Token
  alias Coherence.CredentialStore.Server

  def create_login(conn, user_data, _opts \\ []) do
    token = Token.generate_token()

    Server.put_credentials(token, %{id: user_data.id})

    conn = assign(conn, :current_user, user_data)
    assign(conn, :auth_token, token)
  end
end
