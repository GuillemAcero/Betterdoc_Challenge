# Seed file used to populate the database

alias BetterdocChallenge.{Case, Contact}

# TODO Temporal seeds

# Create 5 cases
Enum.each(1..5, fn x ->
  Case.changeset(%{})
  |> BetterdocChallenge.Repo.insert!()
end)

# Cases 1,2 and 3 will have 1 contact while case 5 will have 3 contacts
Enum.each([1, 2, 3, 5, 5, 5], fn case_id ->
  Contact.changeset(%{
    title: "Title for case #{case_id}",
    first_name: "FirstName #{case_id}",
    last_name: "LastName #{case_id}",
    mobile_phone_number: "#{case_id}-#{case_id}-#{case_id}",
    address: "Addresss of case #{case_id}",
    case_id: case_id
  })
  |> BetterdocChallenge.Repo.insert!()
end)
