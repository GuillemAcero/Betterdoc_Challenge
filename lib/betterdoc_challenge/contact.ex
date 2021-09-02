defmodule BetterdocChallenge.Contact do
  @moduledoc "Schema defining a case"

  use Ecto.Schema

  import Ecto.Changeset

  alias BetterdocChallenge.Repo

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
    |> validate_phone()
  end

  def get_by_id(id) do
    __MODULE__
    |> Repo.get(id)
  end

  # TODO ALL TESTING
  def create(params) do
    params
    |> changeset()
    |> Repo.insert()
  end

  def update(id, params) do
    id
    |> get_by_id()
    |> changeset(params)
    |> Repo.update()
  end

  def delete(id) do
    __MODULE__
    |> Repo.get(id)
    |> Repo.delete()
  end

  ### PRIV
  defp validate_phone(changes) do
    if valid_regex?(get_field(changes, :mobile_phone_number)) do
      changes
    else
      add_error(changes, :mobile_phone_number, "Can only contain numbers")
    end
  end

  defp valid_regex?(nil), do: true

  defp valid_regex?(phone), do: Regex.match?(~r{\A\d*\z}, phone)
end
