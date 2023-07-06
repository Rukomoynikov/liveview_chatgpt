defmodule LiveviewChatgpt.ChatBot.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chatbot_conversations" do
    has_many :messages, LiveviewChatgpt.ChatBot.Message, preload_order: [desc: :inserted_at]
    field :resolved_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:resolved_at])
  end
end
