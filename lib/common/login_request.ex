defmodule LoginRequest do

  @language "en-US"
  @codepage 1252
  @strRoom ""
  @strRoomUrl "https://google.com"
  @token ""
  @app ""
  @flags 0
  @documentUrl ""
  @platform "Linux x86_64"
  @userAgent "5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36"

  defstruct nMode: 2, # GUEST MODE
    name: "Guest",
    pass: "Pass"

  @spec toSM(%LoginRequest{}):: %SocketMessage{}
  def toSM(loginReq) do
    # 0 is Unknow sender, 1 is ServerID
    sm = %SocketMessage{type: MessageTypes.logon}
      |> SocketMessage.setAddress(0, 1)

    buf = sm.buf
        # mode
        |> DataBuffer.writeInt32(loginReq.nMode)
        # write version
        |> DataBuffer.writeInt16(1103) # family - JSONLINE
        |> DataBuffer.writeInt16(5) # major
        |> DataBuffer.writeInt16(5) # minor
        |> DataBuffer.writeInt16(0) # beta
        |> DataBuffer.writeInt16(83) # server protocol F13_DF13
        |> DataBuffer.writeInt16(0) # Shell version
        |> DataBuffer.writeInt16(@flags) # Flags
        |> DataBuffer.writeInt16(0)
        |> DataBuffer.writeInt16(0)
        # # name
        |> DataBuffer.writeUTFString(loginReq.name)
        |> DataBuffer.writeUTFString(loginReq.pass)

        # # write GUID
        |> DataBuffer.writeInt32(0) # uint32Data1
        |> DataBuffer.writeInt16(0) # uint16Data2
        |> DataBuffer.writeInt16(0) # uint16Data3
        |> DataBuffer.writeListUint8([0, 0, 0, 0, 0, 0, 0, 0])

        # # meta data
        |> DataBuffer.writeUTFString(@language)
        |> DataBuffer.writeUTFString(@platform)
        |> DataBuffer.writeInt32(@codepage)
        |> DataBuffer.writeUTFString(@strRoom)
        |> DataBuffer.writeUTFString(@token)
        |> DataBuffer.writeUTFString(@strRoomUrl)
        |> DataBuffer.writeUTFString(@app)
        |> DataBuffer.writeInt32(@flags)
        |> DataBuffer.writeUTFString(@userAgent)
        |> DataBuffer.writeUTFString(@documentUrl)


    SocketMessage.setBuf(sm, buf)
  end

end
