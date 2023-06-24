defmodule ApplicationTracker.JobAppTrackerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApplicationTracker.JobAppTracker` context.
  """

  @doc """
  Generate a application.
  """
  def application_fixture(attrs \\ %{}) do
    {:ok, application} =
      attrs
      |> Enum.into(%{
        applied: ~D[2023-06-05],
        company: "some company",
        listing: "some listing",
        status: "some status"
      })
      |> ApplicationTracker.JobAppTracker.create_application()

    application
  end
end
