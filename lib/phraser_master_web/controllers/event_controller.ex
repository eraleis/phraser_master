defmodule PhraserMasterWeb.EventController do
  use PhraserMasterWeb, :controller

  def create(conn, params) do
    spawn(PhraserMaster.EventMatcher, :process_event, [params])

    text(conn, "")
  end
end
