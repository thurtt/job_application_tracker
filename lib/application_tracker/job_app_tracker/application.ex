defmodule ApplicationTracker.JobAppTracker.Application do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applications" do
    field :applied, :date
    field :company, :string
    field :listing, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [:company, :applied, :status, :listing])
    |> validate_required([:company, :applied, :status, :listing])
  end
end
