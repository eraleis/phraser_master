defmodule PhraserMasterWeb.PageView do
  use PhraserMasterWeb, :view
  import PhraserMasterWeb.Router.Helpers

  def redirect_uri do
    page_url(PhraserMasterWeb.Endpoint, :redirect)
  end
end
