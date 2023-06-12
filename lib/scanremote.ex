defmodule Scanremote do
  @moduledoc """
  Documentation for `Scanremote`.
  """

  def call(%{path: "/"}),
    do: %{code: 200, type: "text/plain", body: "OMG Y'ALL!!"}

  # everything else is a 404 response
  def call(_),
    do: %{code: 404, body: "say what now?"}
end
