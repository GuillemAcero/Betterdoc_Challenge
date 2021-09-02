defmodule BetterdocChallenge.CaseTest do
  use BetterdocChallenge.DataCase

  alias BetterdocChallenge.{Case, Repo}

  describe ".changeset/2" do
    test "valid params" do
      changes =
        %{}
        |> Case.changeset()

      assert changes.valid?
    end

    test "invalid params not casted" do
      changes =
        %{invalid: "invalid param"}
        |> Case.changeset()

      assert %Ecto.Changeset{changes: %{}} = changes
      assert changes.valid?
    end
  end

  describe "insert action" do
    test "creates the record in database" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      assert %Case{id: _} = case_record
      assert Repo.all(Case) == [case_record]
    end
  end

  describe "delete action" do
    test "deletes the record from database" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      Repo.delete(case_record)

      assert [] == Repo.all(Case)
    end

    test "deletes case and all his contacts" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      contact =
        BetterdocChallenge.Contact.changeset(%{title: "test contact", case_id: case_record.id})
        |> Repo.insert!()

      assert Repo.all(Case) == [case_record]
      assert Repo.all(BetterdocChallenge.Contact) == [contact]

      Repo.delete(case_record)

      assert Repo.all(Case) == []
      assert Repo.all(BetterdocChallenge.Contact) == []
    end
  end
end
