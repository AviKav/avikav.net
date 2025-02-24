defmodule AvikavNet.Repo.Migrations.AddUsernameCol do
  use Ecto.Migration

  def change do
    drop unique_index(:users, [:email])

    alter table(:users) do
      add :username, :string, null: false
      remove :email
      add :email, :string, null: true, collate: :nocase
    end

    create unique_index(:users, [:username])

    create unique_index(:users, [:email])
  end
end
