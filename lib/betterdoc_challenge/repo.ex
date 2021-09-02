defmodule BetterdocChallenge.Repo do
  use Ecto.Repo,
    otp_app: :betterdoc_challenge,
    adapter: Ecto.Adapters.Postgres
end
