defmodule BetterdocChallenge.Repo.Migrations.CreateCasesTable do
  use Ecto.Migration

  def change do
    create table("cases") do
      timestamps()
    end
  end
end
