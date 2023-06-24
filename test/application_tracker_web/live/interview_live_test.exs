defmodule ApplicationTrackerWeb.InterviewLiveTest do
  use ApplicationTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ApplicationTracker.JobInterviewTrackerFixtures

  @create_attrs %{meet_date: "2023-06-19", type: "some type"}
  @update_attrs %{meet_date: "2023-06-20", type: "some updated type"}
  @invalid_attrs %{meet_date: nil, type: nil}

  defp create_interview(_) do
    interview = interview_fixture()
    %{interview: interview}
  end

  describe "Index" do
    setup [:create_interview]

    test "lists all interviews", %{conn: conn, interview: interview} do
      {:ok, _index_live, html} = live(conn, ~p"/interviews")

      assert html =~ "Listing Interviews"
      assert html =~ interview.type
    end

    test "saves new interview", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/interviews")

      assert index_live |> element("a", "New Interview") |> render_click() =~
               "New Interview"

      assert_patch(index_live, ~p"/interviews/new")

      assert index_live
             |> form("#interview-form", interview: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#interview-form", interview: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/interviews")

      html = render(index_live)
      assert html =~ "Interview created successfully"
      assert html =~ "some type"
    end

    test "updates interview in listing", %{conn: conn, interview: interview} do
      {:ok, index_live, _html} = live(conn, ~p"/interviews")

      assert index_live |> element("#interviews-#{interview.id} a", "Edit") |> render_click() =~
               "Edit Interview"

      assert_patch(index_live, ~p"/interviews/#{interview}/edit")

      assert index_live
             |> form("#interview-form", interview: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#interview-form", interview: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/interviews")

      html = render(index_live)
      assert html =~ "Interview updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes interview in listing", %{conn: conn, interview: interview} do
      {:ok, index_live, _html} = live(conn, ~p"/interviews")

      assert index_live |> element("#interviews-#{interview.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#interviews-#{interview.id}")
    end
  end

  describe "Show" do
    setup [:create_interview]

    test "displays interview", %{conn: conn, interview: interview} do
      {:ok, _show_live, html} = live(conn, ~p"/interviews/#{interview}")

      assert html =~ "Show Interview"
      assert html =~ interview.type
    end

    test "updates interview within modal", %{conn: conn, interview: interview} do
      {:ok, show_live, _html} = live(conn, ~p"/interviews/#{interview}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Interview"

      assert_patch(show_live, ~p"/interviews/#{interview}/show/edit")

      assert show_live
             |> form("#interview-form", interview: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#interview-form", interview: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/interviews/#{interview}")

      html = render(show_live)
      assert html =~ "Interview updated successfully"
      assert html =~ "some updated type"
    end
  end
end
