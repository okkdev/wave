defmodule Manawave.Pubsub do
  def subscribe do
    Phoenix.PubSub.subscribe(Manawave.PubSub, "ManaWave")
  end

  def broadcast(event) do
    Phoenix.PubSub.broadcast(Manawave.PubSub, "ManaWave", {event})
  end

  def broadcast(event, data) do
    Phoenix.PubSub.broadcast(Manawave.PubSub, "ManaWave", {event, data})
  end
end
