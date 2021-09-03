defmodule BetterdocChallengeWeb.RegistrationController do
  use BetterdocChallengeWeb, :controller

  plug Ueberauth

  def new(conn, _) do
    render(conn, :new,
    changeset: BetterdocChallenge.Account.changeset(%{}),
    action: Routes.registration_path(conn, :create)
  )
  end

  def create(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
    case BetterdocChallenge.Account.register(auth_params) do
      {:ok, _account} ->
        redirect(conn, to: Routes.case_path(conn, :index))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end
