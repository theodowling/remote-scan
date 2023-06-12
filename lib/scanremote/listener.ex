defmodule Scanremote.Listener do
  require Logger

  @options [:binary, packet: :line, active: false, reuseaddr: true]

  def start_link(port, handler) do
    # start listening
    {:ok, listener} = :gen_tcp.listen(port, @options)

    Logger.info("Listening on port 5001")

    # spawn a new process that loops forever
    pid = spawn fn -> loop(listener, handler) end

    # return pid
    {:ok, pid}
  end

  defp loop(listener, handler) do
    # block until a new client arrives
    {:ok, socket} = :gen_tcp.accept(listener)

    # start an async Task to reply to the client
    # we punt to another process to avoid blocking the listener
    Task.async(Scanremote.Server, :serve, [socket, handler])

    # tail recursion FTW!
    loop(listener, handler)
  end
end
