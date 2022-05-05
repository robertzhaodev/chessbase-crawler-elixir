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
end
