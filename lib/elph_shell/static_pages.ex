defmodule ElphShell.StaticPages do
  @moduledoc """
  The Contents context.
  """

  import Ecto.Query, warn: false
  alias ElphShell.Repo

  alias Elph.Contents
  alias ElphShell.StaticPages.StaticPage

  def get_static_page(slug) do
    query =
      from(sp in StaticPage,
        where: sp.slug == ^slug,
        where: sp.published == true
      )

    with %{id: id} <- Repo.one!(query) do
      Contents.get_content!(id)
    end
  end
end
