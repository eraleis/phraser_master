defmodule PhraserMasterWeb.PageController do
  use PhraserMasterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
