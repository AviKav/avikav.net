defmodule AvikavNetWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use AvikavNetWeb, :controller` and
  `use AvikavNetWeb, :live_view`.
  """
  use AvikavNetWeb, :html

  embed_templates "layouts/*"
end
