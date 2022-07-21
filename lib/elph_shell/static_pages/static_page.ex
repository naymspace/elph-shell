defmodule ElphShell.StaticPages.StaticPage do
  @moduledoc """
  The StaticPage is a root-content type. It can be published or not and it has a slug that
  it can uniquely be identified by.
  """
  use Ecto.Schema
  use Elph.Contents.ContentType

  import Ecto.Changeset

  content_schema "static_page_contents" do
    field(:slug, :string)
    field(:published, :boolean, default: false)
  end

  @doc false
  def changeset(static_page, attrs) do
    static_page
    |> cast(attrs, [:slug, :published])
    |> validate_required([:slug])
    |> unique_constraint(:slug)
  end
end
