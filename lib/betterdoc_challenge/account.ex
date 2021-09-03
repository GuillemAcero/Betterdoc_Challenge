defmodule BetterdocChallenge.Account do
  use Ecto.Schema

  import Ecto.Changeset

  alias BetterdocChallenge.Repo

  schema "accounts" do
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password, required: true)
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  def register(%Ueberauth.Auth{} = params) do
    %__MODULE__{}
    |> changeset(extract_account_params(params))
    |> Repo.insert()
  end

  defp extract_account_params(%{credentials: %{other: other}, info: info}) do
    info
    |> Map.from_struct()
    |> Map.merge(other)
  end

  ### PRIV

  defp encrypt_password(%{valid?: true, changes: %{password: pw}} = changeset) do
    put_change(changeset, :encrypted_password, Argon2.hash_pwd_salt(pw))
  end

  defp encrypt_password(changeset) do
    changeset
  end
end
