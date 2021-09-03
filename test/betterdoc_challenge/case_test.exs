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

  describe ".all/0" do
    test "returns all the cases" do
      Enum.map(1..5, fn _ ->
        Case.changeset(%{}) |> Repo.insert!()
      end)

      assert length(Case.all()) == 5
    end

    test "with no cases returns empty list" do
      assert Case.all() == []
    end
  end

  describe ".get_by_id/1" do
    test "valid id returns all the case" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      assert %Case{} = Case.get_by_id(case_record.id)
    end

    test "not found id returns nil" do
      assert Case.get_by_id(123) == nil
    end

    test "invalid id returns nil" do
      assert Case.get_by_id("invalid") == nil
    end
  end
end
