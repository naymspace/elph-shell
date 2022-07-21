defmodule ElphShellWeb.StaticPageController do
  use ElphShellWeb, :controller

  alias ElphShell.StaticPages

  action_fallback(ElphShellWeb.FallbackController)

  def show(conn, %{"slug" => slug}) do
    content = StaticPages.get_static_page(slug)

    conn
    |> put_view(ElphWeb.ContentView)
    |> render("show.json", content: content)
  end
end
