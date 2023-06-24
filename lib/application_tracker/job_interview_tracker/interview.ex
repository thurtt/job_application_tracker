defmodule ApplicationTracker.JobInterviewTracker.Interview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interviews" do
    field :meet_date, :date
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(interview, attrs) do
    interview
    |> cast(attrs, [:meet_date, :type])
    |> validate_required([:meet_date, :type])
  end
end
