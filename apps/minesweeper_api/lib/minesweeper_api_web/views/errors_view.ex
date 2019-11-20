defmodule MinesweeperApiWeb.ErrorsView do
  use MinesweeperApiWeb, :view

  def render("400.json", _assigns) do
    %{stratus: :error, code: 400}
  end
end
