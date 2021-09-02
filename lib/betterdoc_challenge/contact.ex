defmodule BetterdocChallenge.Contact do
  @moduledoc "Schema defining a case"

  use Ecto.Schema

  import Ecto.Changeset

  schema "contacts" do
    field(:title, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:mobile_phone_number, :string)
    field(:address, :string)

    belongs_to(:case, BetterdocChallenge.Case)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:title, :first_name, :last_name, :mobile_phone_number, :address, :case_id])
    |> validate_required([:case_id])
  end
end
