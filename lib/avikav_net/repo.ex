defmodule AvikavNet.Repo do
  use Ecto.Repo,
    otp_app: :avikav_net,
    adapter: Ecto.Adapters.SQLite3
end
