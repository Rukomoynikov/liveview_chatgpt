defmodule LiveviewChatgpt.Repo do
  use Ecto.Repo,
    otp_app: :liveview_chatgpt,
    adapter: Ecto.Adapters.Postgres
end
