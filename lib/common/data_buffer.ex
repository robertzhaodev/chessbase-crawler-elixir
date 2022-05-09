defmodule DataBuffer do
  require Logger

  defstruct nPos: 0, nSize: 0, bin: <<>>, nSizeMarker: [], nMarkedSize: []

  defp _incSize(db, nLen ) do
    db |> Map.put(:nPos, db.nPos + nLen)
       |> Map.put(:nSize, db.nSize + nLen)
  end

  # defp _swapBytes(db, nStart, nLen) do
  #     bl = binary_part(db.bin, 0, nStart)
  #     bc = binary_part(db.bin, nStart, nLen)
  #     br = binary_part(db.bin, nStart + nLen, byte_size(db.bin) - nStart - nLen)

  #     sb = bc
  #       |> :binary.bin_to_list
  #       |> Enum.reverse
  #       |> :binary.list_to_bin

  #     Map.put(db, :bin, bl <> sb <> br)
  # end

  def getSum(db) do
    :binary.bin_to_list(db.bin)
     |> Enum.sum()
  end

  def writeAllBin(db, bin) do
    db |> Map.put(:bin, db.bin <> bin)
       |> _incSize(byte_size(bin))
  end

  def writeInt32(db, value) do
    if is_integer(value) do
      db |> Map.put(:bin, db.bin <> <<value::32>>)
        #  |> _swapBytes(byte_size(db.bin), 4)
         |> _incSize(4)
    else
      Logger.error("writeInt32: Value is not inte");
      db
    end
  end

  def writeInt16(db, value) do
    if is_integer(value) do
      db  |> Map.put(:bin, db.bin <> <<value::16>>)
          # |> _swapBytes(byte_size(db.bin), 2)
          |> _incSize(2)
    else
      Logger.error("writeInt16: Value is not inte");
      db
    end
  end

    def writeInt8(db, value) do
    if is_integer(value) do
      db |> _incSize(1) |> Map.put(:bin, db.bin <> <<value::8>>)
    else
      Logger.error("writeInt8: Value is not inte");
      db
    end
  end

  @spec writeUTFString(%DataBuffer{}, list | bitstring) :: any
  def writeUTFString(db, val) do
    nLen = byte_size(val)

    db |> writeInt32(nLen)
       |> writeListUint8(to_charlist(val))
  end

  def writeListUint8(db, list) do
    db = _incSize(db, length(list))
    Enum.reduce list, db, fn(elm, acc) -> writeInt8(acc, elm) end
  end
end
