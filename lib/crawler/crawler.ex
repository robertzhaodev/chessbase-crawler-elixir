defmodule Crawler do
  require Logger
  use WebSockex

  def start(url) do
    Logger.info("Connecting to #{url}...")

    headers = [
      {"Origin", "https://database.chessbase.com"}
    ]
    # {:ok, pid} = WebSockex.start_link(url, __MODULE__, :fake_state, extra_headers: headers)
    _send_login_request(0)

    # {:ok, pid}
  end

  # Send login request
  defp _send_login_request(pid) do
    loginBinary = %LoginRequest{} |> LoginRequest.toSM() |> SocketMessage.toBinary(true, true)

    IO.puts(inspect(loginBinary))

    rqBinary = "1b5a0000000000000000000000000001dd000000020000004d040500050000005300000000000000000000000500000047756573740400000050617373d98caccc3f33ecfbf09446829a9da20302000000656e080000004d6163496e74656ce4040000000000000000000000000000000000008000000072000000352e3020284d6163696e746f73683b20496e74656c204d6163204f5320582031305f31355f3729204170706c655765624b69742f3533372e333620284b48544d4c2c206c696b65204765636b6f29204368726f6d652f3130302e302e343839362e313237205361666172692f3533372e333600000000"

    loginReq = rqBinary |> String.upcase() |> Base.decode16!()
    IO.puts(inspect(loginReq))
    # WebSockex.send_frame(pid, {:binary, loginReq})
  end

  # Handle disconnect
  def handle_connect(_conn, state) do
    Logger.info("WS connected!")
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts "Sending #{type} frame with payload: #{msg}"
    {:reply, frame, state}
  end

  def handle_disconnect(%{reason: {type, reason}}, state) do
    Logger.info("WS close with reason: #{type} - #{reason}")
    {:ok, state}
  end

  def handle_frame(frame, state) do
    IO.puts "Received Message - Type: #{inspect frame}"
    {:ok, state}
  end

end
