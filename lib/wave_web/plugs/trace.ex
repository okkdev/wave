defmodule WaveWeb.Plugs.Trace do
  import Plug.Conn
  import Phoenix.Controller

  def init(args), do: args

  def call(conn, _opts) do
    case get_session(conn, :traced) do
      true ->
        conn

      _ ->
        conn
        |> IO.inspect()
        |> put_session(:traced, false)
        |> redirect(to: "/tracing")
        |> halt()
    end
  end
end
