defmodule LoginRequest do

  @language "en-US"
  @codepage 1252
  @strRoom ""
  @strRoomUrl "https://google.com"
  @token ""
  @app ""
  @flags 0
  @documentUrl ""

  defstruct nMode: 2, # GUEST MODE
    name: "Guest",
    pass: "Pass"

  @spec toSM(%LoginRequest{}):: %SocketMessage{}
  def toSM(loginReq) do
    # 0 is Unknow sender, 1 is ServerID
    sm = %SocketMessage{type: MessageTypes.logon} |> SocketMessage.setAddress(0, 1)

    buf = DataBuffer.writeInt32(sm.buf, loginReq.nMode);

    SocketMessage.setBuf(sm, buf)
  end

end
