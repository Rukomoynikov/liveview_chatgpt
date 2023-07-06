defmodule LiveviewChatgpt.Chatbot do
  @moduledoc """
  The Chatbot Context
  """

  import Ecto.Query, warn: false
  alias LiveviewChatgpt.Repo

  alias LiveviewChatgpt.ChatBot.{Conversation, Message}

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
end
