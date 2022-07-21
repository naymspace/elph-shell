defmodule ElphShell.Repo.Migrations.CreateStaticPageContents do
  use Ecto.Migration
  use Elph.Migration

  def change do
    create table(:static_page_contents, primary_key: false) do
      add(:slug, :string, null: false)
      add(:published, :boolean, default: false, null: false)

      add_content_field()
    end

    create(unique_index(:static_page_contents, [:slug]))
  end
end
