defmodule LiveviewChatgpt.ChatBot.Message do
  @derive {Jason.Encoder, only: [:role, :content]}

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
    |> cast(attrs, [:role, :content])
    |> validate_required([:role, :content])
  end
end
