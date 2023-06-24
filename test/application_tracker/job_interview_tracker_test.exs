defmodule ApplicationTracker.JobInterviewTrackerTest do
  use ApplicationTracker.DataCase

  alias ApplicationTracker.JobInterviewTracker

  describe "interviews" do
    alias ApplicationTracker.JobInterviewTracker.Interview

    import ApplicationTracker.JobInterviewTrackerFixtures

    @invalid_attrs %{meet_date: nil, type: nil}

    test "list_interviews/0 returns all interviews" do
      interview = interview_fixture()
      assert JobInterviewTracker.list_interviews() == [interview]
    end

    test "get_interview!/1 returns the interview with given id" do
      interview = interview_fixture()
      assert JobInterviewTracker.get_interview!(interview.id) == interview
    end

    test "create_interview/1 with valid data creates a interview" do
      valid_attrs = %{meet_date: ~D[2023-06-19], type: "some type"}

      assert {:ok, %Interview{} = interview} = JobInterviewTracker.create_interview(valid_attrs)
      assert interview.meet_date == ~D[2023-06-19]
      assert interview.type == "some type"
    end

    test "create_interview/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JobInterviewTracker.create_interview(@invalid_attrs)
    end

    test "update_interview/2 with valid data updates the interview" do
      interview = interview_fixture()
      update_attrs = %{meet_date: ~D[2023-06-20], type: "some updated type"}

      assert {:ok, %Interview{} = interview} = JobInterviewTracker.update_interview(interview, update_attrs)
      assert interview.meet_date == ~D[2023-06-20]
      assert interview.type == "some updated type"
    end

    test "update_interview/2 with invalid data returns error changeset" do
      interview = interview_fixture()
      assert {:error, %Ecto.Changeset{}} = JobInterviewTracker.update_interview(interview, @invalid_attrs)
      assert interview == JobInterviewTracker.get_interview!(interview.id)
    end

    test "delete_interview/1 deletes the interview" do
      interview = interview_fixture()
      assert {:ok, %Interview{}} = JobInterviewTracker.delete_interview(interview)
      assert_raise Ecto.NoResultsError, fn -> JobInterviewTracker.get_interview!(interview.id) end
    end

    test "change_interview/1 returns a interview changeset" do
      interview = interview_fixture()
      assert %Ecto.Changeset{} = JobInterviewTracker.change_interview(interview)
    end
  end
end
