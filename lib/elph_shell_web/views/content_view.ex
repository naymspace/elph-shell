defmodule ElphShellWeb.ContentView do
  use ElphShellWeb, :view

  def render("static_page.json", %{content: content}) do
    %{
      slug: content.slug,
      published: content.published
    }
  end
end
