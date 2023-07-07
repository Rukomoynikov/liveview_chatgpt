defmodule LiveviewChatgpt.ChatBot.OpenAiService do
  defp default_system_prompt do
    """
    You are a chatbot that helps people to learn English language by practiciing different dialogs with them
    """
  end

  def call(prompts, opts \\ []) do
    %{
      model: "gpt-3.5-turbo",
      messages:
        Enum.concat(
          [%{role: "system", content: default_system_prompt()}],
          prompts
        ),
      temperature: 0.9
    }
    |> Jason.encode!()
    |> request(opts)
    |> parse_response()
  end

  defp request(body_params, _request_params) do
    Finch.build(:post, "https://api.openai.com/v1/chat/completions", headers(), body_params)
    |> Finch.request(LiveviewChatgpt.Finch)
  end

  defp headers do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{Application.get_env(:liveview_chatgpt, :open_ai_api_key)}"}
    ]
  end

  defp parse_response({:ok, %Finch.Response{body: body}}) do
    messages =
      Jason.decode!(body)
      |> Map.get("choices", [])
      |> Enum.reverse()

    dbg(body)

    case messages do
      [%{"message" => message} | _] ->
        message

      _ ->
        "{}"
    end
  end

  defp parse_response(error), do: error
end
