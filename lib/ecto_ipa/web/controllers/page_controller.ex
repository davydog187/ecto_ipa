defmodule EctoIpa.Web.PageController do
  use EctoIpa.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
