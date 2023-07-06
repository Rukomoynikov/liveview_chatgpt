defmodule LiveviewChatgpt.ChatBot.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chatbot_messages" do
    field :role, :string
    field :content, :string

    belongs_to :conversation, LiveviewChatgpt.ChatBot.Conversation

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [])
    |> validate_required([])
  end
end
