defmodule BetterdocChallenge.Repo.Migrations.CreateContactsTable do
  use Ecto.Migration

  def change do
    create table("contacts") do
      add :title, :string
      add :first_name, :string
      add :last_name, :string
      add :mobile_phone_number, :string
      add :address, :string
      add :case_id, references(:cases), on_delete: :delete_all

      timestamps()
    end
  end
end
