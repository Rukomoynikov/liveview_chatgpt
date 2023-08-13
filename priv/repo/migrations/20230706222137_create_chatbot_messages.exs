defmodule LiveviewChatgpt.Repo.Migrations.CreateChatbotMessages do
  use Ecto.Migration

  def change do
    create table(:chatbot_messages) do
      add :conversation_id, references(:chatbot_conversations, on_delete: :nothing)
      add :content, :text
      add :role, :string

      timestamps()
    end

    create index(:chatbot_messages, [:conversation_id])
  end
end
