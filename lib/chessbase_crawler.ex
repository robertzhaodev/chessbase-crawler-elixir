defmodule ChessbaseCrawler do
  @wsUrl Application.get_env(:chessbase_crawler, :wsUrl)

  # The function called when start application
  def start(_type, _args) do
    Crawler.start(@wsUrl)
  end
end
