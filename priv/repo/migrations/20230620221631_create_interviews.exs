defmodule ApplicationTracker.Repo.Migrations.CreateInterviews do
  use Ecto.Migration

  def change do
    create table(:interviews) do
      add :meet_date, :date
      add :type, :string

      timestamps()
    end
  end
end
