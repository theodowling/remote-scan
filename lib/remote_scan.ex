defmodule RemoteScan do
  @moduledoc """
  Documentation for `RemoteScan`.
  """

  def call(%{path: "/scan/color", verb: "POST"}) do
    doc_name = "image-#{System.system_time()}.png"
    System.shell("scanimage --progress --format png --mode color --resolution 300 > /opt/paperless-ngx/consume/#{doc_name}", into: IO.stream())
    %{code: 200, type: "application/json", body: "{outcome: \"Success\"}"}
  end

  def call(%{path: "/scan/gray", verb: "POST"}) do
    doc_name = "image-#{System.system_time()}.png"
    System.shell("scanimage --progress --format png --mode gray --resolution 300 > /opt/paperless-ngx/consume/#{doc_name}", into: IO.stream())
    %{code: 200, type: "application/json", body: "{outcome: \"Success\"}"}
  end

  def call(%{path: "/scan/black-and-white", verb: "POST"}) do
    doc_name = "image-#{System.system_time()}.png"
    System.shell("scanimage --progress --format png --mode lineart --resolution 300 > /opt/paperless-ngx/consume/#{doc_name}", into: IO.stream())
    %{code: 200, type: "application/json", body: "{outcome: \"Success\"}"}
  end

  # everything else is a 404 response
  def call(_),
    do: %{code: 404, body: "Not Found"}
end
