defmodule BetterdocChallenge.Case do
  @moduledoc "Schema defining a case"

  use Ecto.Schema

  import Ecto.Changeset

  alias BetterdocChallenge.Repo

  schema "cases" do
    has_many(:contacts, BetterdocChallenge.Contact, on_delete: :delete_all)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [])
  end

  def all() do
    __MODULE__
    |> Repo.all()
  end

  def get_by_id(case_id) when is_binary(case_id) do
    try do
      get_by_id(String.to_integer(case_id))
    rescue
      _ -> nil
    end
  end

  def get_by_id(case_id) when is_number(case_id) do
    __MODULE__
    |> Repo.get(case_id)
    |> Repo.preload([:contacts])
  end
end
