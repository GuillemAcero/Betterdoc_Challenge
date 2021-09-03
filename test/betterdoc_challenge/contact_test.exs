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

  describe ".get_by_id/1" do
    test "valid id returns all the contact" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      assert %Contact{} = Contact.get_by_id(contact.id)
    end

    test "not found id returns nil" do
      assert Contact.get_by_id(123) == nil
    end

    test "invalid id returns nil" do
      assert Contact.get_by_id("invalid") == {:error, :invalid_id}
    end
  end

  describe ".create/1" do
    test "with valid params creates the contact" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      params = %{
        case_id: case_record.id,
        first_name: "first",
        last_name: "last"
      }

      {:ok, contact} = Contact.create(params)

      assert Repo.all(Contact) == [contact]
    end

    test "invalid params returns error" do
      case_record = Case.changeset(%{}) |> Repo.insert!()

      params = %{
        case_id: case_record.id,
        mobile_phone_number: "invalid field"
      }

      assert {:error, changeset} = Contact.create(params)
      refute changeset.valid?
    end
  end

  describe ".update/2" do
    test "with valid params updates the contact" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      assert Repo.all(Contact) == [contact]

      {:ok, updated_contact} =
        Contact.update(contact.id, %{first_name: "updated name", last_name: "updated_name"})

      assert Repo.all(Contact) == [updated_contact]
    end

    test "not found id returns error" do
      {:error, changeset} = Contact.update(123, %{case_id: 1, first_name: "Not existent"})

      refute changeset.valid?
      assert changeset.errors == [id: {"Not found with id", []}]
    end

    test "invalid id returns error" do
      {:error, changeset} =
        Contact.update("invalid_id", %{case_id: 1, first_name: "Not existent"})

      refute changeset.valid?
      assert changeset.errors == [id: {"Invalid id provided", []}]
    end
  end

  describe ".delete/1" do
    test "deletes the record from database" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      Contact.delete(contact.id)

      assert [] == Repo.all(Contact)
    end

    test "deletes only contact, not his case" do
      case_record = Case.changeset(%{}) |> Repo.insert!()
      contact = Contact.changeset(%{case_id: case_record.id}) |> Repo.insert!()

      assert Repo.all(Case) == [case_record]
      assert Repo.all(BetterdocChallenge.Contact) == [contact]

      Contact.delete(contact.id)

      assert [%Case{}] = Repo.all(Case)
      assert Repo.all(Contact) == []
    end

    test "with invalid id throws error. (with no info)" do
      {:error, changeset} = Contact.delete("invalid")

      refute changeset.valid?
    end
  end
end
