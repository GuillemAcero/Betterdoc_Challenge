defmodule BetterdocChallenge.Case do
  @moduledoc "Schema defining a case"

  use Ecto.Schema

  import Ecto.Changeset

  schema "cases" do
    has_many(:contacts, BetterdocChallenge.Contact, on_delete: :delete_all)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [])
  end
end
