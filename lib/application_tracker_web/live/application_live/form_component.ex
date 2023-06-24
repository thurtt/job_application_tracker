defmodule ApplicationTrackerWeb.ApplicationLive.FormComponent do
  use ApplicationTrackerWeb, :live_component

  alias ApplicationTracker.JobAppTracker

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage application records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="application-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:company]} type="text" label="Company" />
        <.input field={@form[:applied]} type="date" label="Applied" />
        <.input field={@form[:status]} type="select" label="Status" options={application_states()} />
        <.input field={@form[:listing]} type="text" label="Listing" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Application</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{application: application} = assigns, socket) do
    changeset = JobAppTracker.change_application(application)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"application" => application_params}, socket) do
    changeset =
      socket.assigns.application
      |> JobAppTracker.change_application(application_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"application" => application_params}, socket) do
    save_application(socket, socket.assigns.action, application_params)
  end

  defp save_application(socket, :edit, application_params) do
    case JobAppTracker.update_application(socket.assigns.application, application_params) do
      {:ok, application} ->
        notify_parent({:saved, application})

        {:noreply,
         socket
         |> put_flash(:info, "Application updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_application(socket, :new, application_params) do
    case JobAppTracker.create_application(application_params) do
      {:ok, application} ->
        notify_parent({:saved, application})

        {:noreply,
         socket
         |> put_flash(:info, "Application created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp application_states() do
    ["Open", "Rejected", "Dark", "Ghosted", "Not as Described", "Declined", "Too Slow"]
  end
end
