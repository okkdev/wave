defmodule Wave.Pubsub do
  def subscribe do
    Phoenix.PubSub.subscribe(Wave.PubSub, "Wave")
  end

  def broadcast(event) do
    Phoenix.PubSub.broadcast(Wave.PubSub, "Wave", event)
  end

  def broadcast(event, data) do
    Phoenix.PubSub.broadcast(Wave.PubSub, "Wave", {event, data})
  end
end
