defmodule Screenshot do
  use Hound.Helpers
  import ExUnit.Assertions

  # assert screenshot on failure (Shamelessly stolen from stackoverflow)
  defmacro assert_sof(assertion) do
    quote do
      try do
        assert unquote(assertion)
      rescue
        error ->
          take_screenshot()
          raise error
      end
    end
  end

  # refute screenshot on failure (I did this myself, impressive eh?)
  defmacro refute_sof(assertion) do
    quote do
      try do
        refute unquote(assertion)
      rescue
        error ->
          take_screenshot()
          raise error
      end
    end
  end

end