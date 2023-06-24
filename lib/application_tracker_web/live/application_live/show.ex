defmodule ApplicationTrackerWeb.ApplicationLive.Show do
  use ApplicationTrackerWeb, :live_view

  alias ApplicationTracker.JobAppTracker

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:application, JobAppTracker.get_application!(id))}
  end

  defp page_title(:show), do: "Show Application"
  defp page_title(:edit), do: "Edit Application"
end
