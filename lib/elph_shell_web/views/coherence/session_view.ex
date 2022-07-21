defmodule ElphShellWeb.Coherence.SessionView do
  use ElphShellWeb.Coherence, :view

  def render("session.json", %{auth_token: auth_token}) do
    %{
      auth_token: auth_token
    }
  end

  def render("error.json", %{error: error}) do
    %{
      error: error
    }
  end

  def render("error.json", _opts) do
    %{
      error: "Invalid credentials"
    }
  end
end
