defmodule ApplicationTracker.JobInterviewTrackerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApplicationTracker.JobInterviewTracker` context.
  """

  @doc """
  Generate a interview.
  """
  def interview_fixture(attrs \\ %{}) do
    {:ok, interview} =
      attrs
      |> Enum.into(%{
        meet_date: ~D[2023-06-19],
        type: "some type"
      })
      |> ApplicationTracker.JobInterviewTracker.create_interview()

    interview
  end
end
