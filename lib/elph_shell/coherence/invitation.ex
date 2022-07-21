defmodule ElphShell.Coherence.Invitation do
  @moduledoc """
  Schema to support inviting someone to create an account.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "invitations" do
    field(:name, :string)
    field(:email, :string)
    field(:token, :string)

    timestamps()
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email token)a)
    |> validate_required([:name, :email])
    |> validate_format(
      :email,
      # credo:disable-for-next-line
      ~r<(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])>
    )
    |> unique_constraint(:email)
  end

  @doc """
  Creates a changeset for a new schema
  """
  @spec new_changeset(Map.t()) :: Ecto.Changeset.t()
  def new_changeset(params \\ %{}) do
    changeset(%__MODULE__{}, params)
  end
end
