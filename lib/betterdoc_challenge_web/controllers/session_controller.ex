defmodule BetterdocChallengeWeb.SessionController do
  use BetterdocChallengeWeb, :controller

  def new(conn, _params) do
    render(conn, :new, changeset: conn, action: "/login")
  end
end
