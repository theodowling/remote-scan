defmodule Scanremote do
  @moduledoc """
  Documentation for `Scanremote`.
  """

  def call(%{path: "/scan/color", verb: "POST"}) do
    System.shell("scanimage --progress --format png --mode color --resolution 300 > /opt/paperless-ngx/consume/image.png", into: IO.stream())
    %{code: 200, type: "text/plain", body: "Scanned"}
  end

  def call(%{path: "/scan/gray", verb: "POST"}) do
    System.shell("scanimage --progress --format png --mode gray --resolution 300 > /opt/paperless-ngx/consume/image.png", into: IO.stream())
    %{code: 200, type: "text/plain", body: "Scanned"}
  end

  # everything else is a 404 response
  def call(_),
    do: %{code: 404, body: "Not Found"}
end
