defmodule BetterdocChallengeWeb.ContactController do
  use BetterdocChallengeWeb, :controller

  alias BetterdocChallenge.Contact

  def new(conn, params) do
    case_id = Map.get(params, "case_id")

    render(conn, "form.html",
      case_id: case_id,
      changeset: Contact.changeset(%{}),
      route: Routes.contact_path(conn, :create)
    )
  end

  def create(conn, params) do
    contact_params = Map.get(params, "contact")

    contact_params
    |>Contact.create()
    |> case do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, Map.get(contact_params, "case_id")))

      {:error, _} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, Map.get(contact_params, "case_id")))
    end
  end

  def edit(conn, params) do
    id = Map.get(params, "id")

    changeset =
      id
      |> Contact.get_by_id()
      |> Contact.changeset(%{})

    render(conn, "form.html",
      case_id: changeset.data.case_id,
      changeset: changeset,
      route: Routes.contact_path(conn, :update, id)
    )
  end

  def update(conn, params) do
    id = Map.get(params, "id")
    contact_params = Map.get(params, "contact")

    Contact.update(id, contact_params)
    |> case do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, Map.get(contact_params, "case_id")))

      {:error, _} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, Map.get(contact_params, "case_id")))
    end
  end

  def delete(conn, params) do
    id = Map.get(params, "id")

    Contact.delete(id)
    |> case do
      {:ok, %{case_id: case_id}} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, case_id))

      {:error, %{data: %{case_id: case_id}}} ->
        conn
        |> redirect(to: Routes.case_path(conn, :show, case_id))
    end
  end
end
