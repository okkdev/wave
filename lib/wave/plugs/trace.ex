defmodule Wave.Plugs.Trace do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _opts) do
    assign(conn, :traced, false)
  end
end
