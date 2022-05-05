defmodule DataBuffer do
  defstruct nPos: 0, nSize: 0, bin: <<>>, nSizeMarker: [], nMarkedSize: []

  defp _incSize(db, nLen ) do
    db |> Map.put(:nPos, db.nPos + nLen)
       |> Map.put(:nSize, db.nSize + nLen)
  end

  def writeInt32(db, value) do
    _incSize(db, 32)
    db |> Map.put(:bin, db.bin <> <<value::32>>)
  end
end
