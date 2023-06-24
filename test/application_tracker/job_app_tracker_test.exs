defmodule ApplicationTracker.JobAppTrackerTest do
  use ApplicationTracker.DataCase

  alias ApplicationTracker.JobAppTracker

  describe "applications" do
    alias ApplicationTracker.JobAppTracker.Application

    import ApplicationTracker.JobAppTrackerFixtures

    @invalid_attrs %{applied: nil, company: nil, listing: nil, status: nil}

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert JobAppTracker.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert JobAppTracker.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      valid_attrs = %{applied: ~D[2023-06-05], company: "some company", listing: "some listing", status: "some status"}

      assert {:ok, %Application{} = application} = JobAppTracker.create_application(valid_attrs)
      assert application.applied == ~D[2023-06-05]
      assert application.company == "some company"
      assert application.listing == "some listing"
      assert application.status == "some status"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JobAppTracker.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      update_attrs = %{applied: ~D[2023-06-06], company: "some updated company", listing: "some updated listing", status: "some updated status"}

      assert {:ok, %Application{} = application} = JobAppTracker.update_application(application, update_attrs)
      assert application.applied == ~D[2023-06-06]
      assert application.company == "some updated company"
      assert application.listing == "some updated listing"
      assert application.status == "some updated status"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = JobAppTracker.update_application(application, @invalid_attrs)
      assert application == JobAppTracker.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = JobAppTracker.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> JobAppTracker.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = JobAppTracker.change_application(application)
    end
  end
end
