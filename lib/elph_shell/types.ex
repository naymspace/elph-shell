defmodule ElphShell.Types do
  @moduledoc """
  Implementation of Elph.Contents.Types
  """
  use Elph.Contents.Types

  elph_types()

  type(:static_page, ElphShell.StaticPages.StaticPage, ElphShellWeb.ContentView)
end
