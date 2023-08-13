defmodule LiveviewChatgpt.Chatbot do
  @moduledoc """
  The Chatbot Context
  """

  import Ecto.Query, warn: false
  alias LiveviewChatgpt.Repo

  alias LiveviewChatgpt.ChatBot.{Conversation, Message}
  alias LiveviewChatgpt.ChatBot.OpenAiService

  def generate_response(conversation, messages) do
    last_five_messages =
      Enum.slice(messages, 0..4)
      |> Enum.reverse()

    create_message(conversation, OpenAiService.call(last_five_messages))
  end

  def list_conversations do
    Repo.all(Conversation)
  end

  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
  end

  def update_conversations(%Conversation{} = conversation, attrs) when is_map(attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  def create_message(%Conversation{} = conversation, attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:conversation, conversation)
    |> Repo.insert()
  end

  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  def list_conversation_messages(conversation) do
    from(m in Message, where: m.conversation_id == ^conversation.id)
    |> Repo.all()
  end
end
