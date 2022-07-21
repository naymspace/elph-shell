defmodule ElphShell.Repo do
  use Ecto.Repo,
    otp_app: :elph_shell,
    adapter: Ecto.Adapters.MyXQL
end
