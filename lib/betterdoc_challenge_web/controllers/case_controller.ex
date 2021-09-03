defmodule BetterdocChallengeWeb.CaseController do
  use BetterdocChallengeWeb, :controller

  alias BetterdocChallenge.Case

  def index(conn, _params) do
    all_cases = Case.all()

    render(conn, "index.html", all_cases: all_cases)
  end

  def show(conn, params) do
    case_id = Map.get(params, "id")

    case Case.get_by_id(case_id) do
      nil -> redirect(conn, to: "/")
      case_data -> render(conn, "show.html", case_data: case_data)
    end
  end
end
