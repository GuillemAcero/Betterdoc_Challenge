defmodule BetterdocChallenge.ContactTest do
  use BetterdocChallenge.DataCase

  alias BetterdocChallenge.{Case, Contact, Repo}

  describe ".changeset/2" do
    test "valid params" do
      params = %{
        title: "Title",
        first_name: "First",
        last_name: "Last",
        mobile_phone_number: "123456789",
        address: "Street Asdf",
        case_id: 1
      }

      changes = Contact.changeset(params)

      assert changes.valid?
    end

    test "case_id required field" do
      changes = Contact.changeset(%{})

      assert %Ecto.Changeset{errors: [case_id: {"can't be blank", [validation: :required]}]} =
               changes
    end

    test "valid with only case_id" do
      changes =
        %{case_id: 1}
        |> Contact.changeset()

      assert changes.valid?
    end

    test "invalid changeset when mobile phone number contains letters" do
      changes =
        %{case_id: 1, mobile_phone_number: "12345f"}
        |> Contact.changeset()

      refute changes.valid?
    end
  end

  describe "insert action" do
    test "creates the record in database" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      assert %Contact{case_id: _} = contact
      assert Repo.all(Contact) == [contact]
    end
  end

  describe "delete action" do
    test "deletes the record from database" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      Repo.delete(contact)

      assert [] == Repo.all(Contact)
    end

    test "deletes only contact, not his case" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      assert Repo.all(Case) == [case_record]
      assert Repo.all(BetterdocChallenge.Contact) == [contact]

      Repo.delete(contact)

      assert [%Case{}] = Repo.all(Case)
      assert Repo.all(Contact) == []
    end
  end
end
