defmodule SocketMessage do
  defstruct type: 0, userType: 0, idReceiver: 0, idSender: 0, nVal: 0, buf: %DataBuffer{}, msgId: 0

  @spec setBuf(map, any) :: map
  def setBuf(sm, buf) do
    Map.put(sm, "buf", buf)
  end

  @spec setAddress(sm:: %SocketMessage{}, idSender:: integer(), idReceiver:: integer()):: %SocketMessage{}
  def setAddress(sm, idSender, idReceiver) do
    newSm = Map.put(sm, "idSender", idSender)
    Map.put(newSm, "idReceiver", idReceiver)
  end
end
