defmodule DataBuffer do
  defstruct nPos: 0, nSize: 0, buffer: <<>>, nSizeMarker: [], nMarkedSize: []
end
