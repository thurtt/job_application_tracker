defmodule ApplicationTracker.Repo.Migrations.IncreaseListingSize do
  use Ecto.Migration

  def change do
    alter table(:applications) do
      modify :listing, :text
    end
  end
end
