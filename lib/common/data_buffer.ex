defmodule DataBuffer do
  defstruct nPos: 0, nSize: 0, bin: <<>>, nSizeMarker: [], nMarkedSize: []

  @spec writeInt32(%DataBuffer{}, binary) :: %DataBuffer{}
  def writeInt32(db, value) do
    Map.put(db, "bin", db["bin"] <> value)
  end
end
