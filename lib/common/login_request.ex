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
  def toSM(lg) do
    sm = %SocketMessage{}
    sm = SocketMessage.setAddress(sm, 0, 1)
    # 0 is Unknow sender
    # 1 is ServerID
    buf = DataBuffer.writeInt32(sm["buf"], lg["nMode"]);

    SocketMessage.setBuf(sm, buf)
  end

end
