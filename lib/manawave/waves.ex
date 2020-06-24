defmodule Manawave.Waves do
  use GenServer
  alias :ets, as: Ets

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    Ets.new(:waves, [:public, :named_table, read_concurrency: true])
    {:ok, :ready}
  end

  def create(%{number: num, time: time}) do
    num = String.to_integer(num)
    Ets.insert(:waves, {num, time})
  end

  def list_all() do
    Ets.match_object(:waves, {:"$1", :"$2"})
    |> Enum.map(fn {n, t} -> %{number: n, time: t} end)
    |> Enum.sort_by(& &1.time, DateTime)
  end

  def list_all_acknowledged() do
    Ets.match_object(:waves, {:"$1", :"$2", :acknowledged})
    |> Enum.map(fn {n, t, _} -> %{number: n, time: t} end)
    |> Enum.sort_by(& &1.time, {:desc, DateTime})
  end

  def acknowledge(num) do
    num = String.to_integer(num)
    [{num, time}] = Ets.lookup(:waves, num)
    Ets.insert(:waves, {num, time, :acknowledged})
  end
end
