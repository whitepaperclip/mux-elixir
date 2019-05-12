defmodule Mux.Video.LiveStreamsTest do
  use ExUnit.Case
  import Tesla.Mock
  doctest Mux.Video.LiveStreams

  @base_url "https://api.mux.com/video/v1/live-streams"

  setup do
    client = Mux.Base.new("token_id", "token_secret", base_url: @base_url)

    mock(fn
      %{method: :get, url: @base_url} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "data" => [Mux.Fixtures.live_stream(), Mux.Fixtures.live_stream()]
          }
        }

      %{method: :post, url: @base_url} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "data" => Mux.Fixtures.live_stream()
          }
        }

      %{method: :get, url: @base_url <> "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY"} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "data" => Mux.Fixtures.live_stream()
          }
        }

      %{method: :delete, url: @base_url <> "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY"} ->
        %Tesla.Env{status: 204, body: ""}

      %{method: :post, url: @base_url <> "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY/reset-stream-key"} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "data" => Mux.Fixtures.live_stream()
          }
        }

      %{method: :post, url: @base_url <> "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY/playback-ids"} ->
        %Tesla.Env{
          status: 201,
          body: %{
            "data" => Mux.Fixtures.playback_id()
          }
        }

      %{method: :put, url: @base_url <> "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY/complete"} ->
        %Tesla.Env{
          status: 204,
          body: ""
        }

      %{
        method: :delete,
        url:
          @base_url <>
              "/aA02skpHXoLrbQm49qIzAG6RtewFOcDEY/playback-ids/FRDDXsjcNgD013rx1M4CDunZ86xkq8A02hfF3b6XAa7iE"
      } ->
        %Tesla.Env{
          status: 204,
          body: ""
        }
    end)

    {:ok, %{client: client}}
  end
end