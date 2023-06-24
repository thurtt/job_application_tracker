defmodule ApplicationTracker.Repo do
  use Ecto.Repo,
    otp_app: :application_tracker,
    adapter: Ecto.Adapters.Postgres
end
