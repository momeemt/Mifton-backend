class DropChannel < ApplicationCable::Channel
  def subscribed
    stream_from "drop_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'drop_channel', drop: data['drop']
  end
end
