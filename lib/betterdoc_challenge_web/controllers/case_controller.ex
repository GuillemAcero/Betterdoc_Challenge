defmodule BetterdocChallengeWeb.CaseController do
  use BetterdocChallengeWeb, :controller

  alias BetterdocChallenge.{Repo, Case}

  def index(conn, _params) do
    all_cases = Case.all()

    render(conn, "index.html", all_cases: all_cases)
  end

  def show(conn, params) do
    case_id = Map.get(params, "case_id")

    render(conn, "show.html", case_data: Case.get_by_id(case_id))
  end
end
