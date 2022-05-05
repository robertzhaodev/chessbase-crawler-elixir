defmodule Crawler do
  require Logger
  use WebSockex

  def start(url) do
    Logger.info("Connecting to #{url}...")

    headers = [
      {"Origin", "https://database.chessbase.com"}
    ]
    WebSockex.start_link(url, __MODULE__, :fake_state, extra_headers: headers)
  end

  def handle_connect(_conn, state) do
    Logger.info("WS connected!")
    loginReq = %LoginRequest{}
    IO.puts(inspect(LoginRequest.toSM(loginReq)));

    {:ok, state}
  end

  def handle_disconnect(%{reason: {:local, reason}}, state) do
    Logger.info("WS close with reason: #{inspect reason}")
    {:ok, state}
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end

  def handle_frame(frame, state) do
    IO.puts "Received Message - Type: #{inspect frame}"
    {:ok, state}
  end

end
