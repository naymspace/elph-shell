# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElphShell.Repo.insert!(%ElphShell.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Elph.Contents

ElphShell.Repo.insert(%ElphShell.Coherence.User{
  name: "admin",
  email: "admin@example.com",
  # "password"
  password_hash: "$2b$12$XIASLa95GbHOoJjCpl7qtuzqh8IK6kbLWCXHUmldGfu.tXiZXJvjm"
})

Contents.persist_content(%{
  name: "Home",
  shared: true,
  type: "static_page",
  published: true,
  slug: "home",
  children: [
    %{
      type: "markdown",
      markdown: """
      # Hello World

      Welcome to this great site!
      Look at this cool stuff:
      """
    },
    %{
      type: "accordion_row",
      title: "Cool Stuff",
      default_open: true,
      children: [
        %{
          type: "markdown",
          markdown: """
          This is supercool stuff, that is open by default
          """
        }
      ]
    },
    %{
      type: "accordion_row",
      title: "Even cooler Stuff",
      children: [
        %{
          type: "markdown",
          markdown: """
          Surprise. Nothing here. You clicked on the clickbait. Haha.
          """
        }
      ]
    },
    %{
      type: "markdown",
      markdown: """
      ## More cool stuff (for real this time)
      [Naymspace](https://naymspace.de)
      [Elph](https://github.com/naymspace/elph)
      """
    }
  ]
})

Contents.persist_content(%{
  name: "Data Protection",
  shared: true,
  type: "static_page",
  published: true,
  slug: "data_protection"
})

Contents.persist_content(%{
  name: "Contact",
  shared: true,
  type: "static_page",
  published: true,
  slug: "contact"
})
