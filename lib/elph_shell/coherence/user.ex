defmodule ElphShell.Coherence.User do
  @moduledoc false
  use Ecto.Schema
  use Coherence.Schema

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    coherence_schema()

    timestamps()
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email)a ++ coherence_fields())
    |> validate_required([:name, :email])
    |> validate_format(
      :email,
      # credo:disable-for-next-line
      ~r<(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])>
    )
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t(), atom) :: Ecto.Changeset.t()
  def changeset(model, params, :password) do
    model
    |> cast(
      params,
      ~w(password password_confirmation reset_password_token reset_password_sent_at)a
    )
    |> validate_coherence_password_reset(params)
  end

  def changeset(model, params, :registration) do
    changeset = changeset(model, params)

    if Config.get(:confirm_email_updates) && Map.get(params, "email", false) && model.id do
      changeset
      |> put_change(:unconfirmed_email, get_change(changeset, :email))
      |> delete_change(:email)
    else
      changeset
    end
  end
end
