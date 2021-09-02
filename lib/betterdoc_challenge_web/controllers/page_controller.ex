defmodule BetterdocChallengeWeb.PageController do
  use BetterdocChallengeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
