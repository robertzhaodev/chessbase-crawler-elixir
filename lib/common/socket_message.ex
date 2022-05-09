defmodule MessageTypes do
  def logon, do: 7002
end

defmodule SocketMessage do

  defstruct type: 0, userType: 0, idReceiver: 0, idSender: 0, nVal: 0, buf: %DataBuffer{}, msgId: 0

  @spec setBuf(map, any) :: map
  def setBuf(sm, buf) do
    sm |> Map.put(:buf, buf)
  end

  @spec setAddress(%SocketMessage{}, integer(), integer()):: %SocketMessage{}
  def setAddress(sm, idSender, idReceiver) do
    sm |> Map.put(:idSender, idSender) |> Map.put(:idReceiver, idReceiver)
  end

  @spec toBinary(%SocketMessage{}, boolean, boolean) :: binary
  def toBinary(sm, isNoId \\ false, isNoCheck \\ false) do

    IO.puts(sm.type)
    newBuf = %DataBuffer{}
      |> DataBuffer.writeInt16(sm.type)
      |> DataBuffer.writeInt32(sm.nVal)
      |> DataBuffer.writeInt32(sm.idSender)
      |> DataBuffer.writeInt16(sm.userType)
      |> DataBuffer.writeInt32(sm.idReceiver)

    buf = case isNoId do
      true -> DataBuffer.writeAllBin(newBuf, sm.buf.bin)
      _ -> buf = newBuf
          |> DataBuffer.writeInt32(sm.msgId)
          |> DataBuffer.writeAllBin(sm.buf.bin)
        # no check sum
        unless isNoCheck do
          buf |> DataBuffer.writeInt16(DataBuffer.getSum(buf))
        else buf end
    end
    buf.bin

  end
end
