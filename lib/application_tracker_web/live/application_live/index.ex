defmodule ApplicationTrackerWeb.ApplicationLive.Index do
  use ApplicationTrackerWeb, :live_view

  alias ApplicationTracker.JobAppTracker
  alias ApplicationTracker.JobAppTracker.Application

  @impl true
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:closed_applications, JobAppTracker.closed_applications())
     |> stream(:open_applications, JobAppTracker.open_applications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Application")
    |> assign(:application, JobAppTracker.get_application!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Application")
    |> assign(:application, %Application{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Applications")
    |> assign(:application, nil)
  end

  @impl true
  def handle_info(
        {ApplicationTrackerWeb.ApplicationLive.FormComponent, {:saved, application}},
        socket
      ) do
    {:noreply, stream_insert(socket, :applications, application)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    application = JobAppTracker.get_application!(id)
    {:ok, _} = JobAppTracker.delete_application(application)

    {:noreply, stream_delete(socket, :applications, application)}
  end
end
