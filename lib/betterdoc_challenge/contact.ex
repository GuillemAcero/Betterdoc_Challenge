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

  def get_by_id(id) when is_binary(id) do
    try do
      get_by_id(String.to_integer(id))
    rescue
      _ -> {:error, :invalid_id}
    end
  end

  def get_by_id(id) when is_number(id) do
    __MODULE__
    |> Repo.get(id)
  end

  def create(params) do
    params
    |> changeset()
    |> Repo.insert()
  end

  def update(id, params) do
    id
    |> get_by_id()
    |> case do
      %__MODULE__{} = contact -> changeset(contact, params)
      nil -> add_error(changeset(params), :id, "Not found with id")
      {:error, _} -> add_error(changeset(params), :id, "Invalid id provided")
    end
    |> Repo.update()
  end

  def delete(id) do
    id
    |> get_by_id()
    |> case do
      %__MODULE__{} = contact -> contact
      _ -> add_error(changeset(%{}), :id, "Could not delete")
    end
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
