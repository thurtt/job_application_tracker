defmodule ApplicationTracker.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :company, :string
      add :applied, :date
      add :status, :string
      add :listing, :string

      timestamps()
    end
  end
end
