ExUnit.start()

# Testing macro exception
# https://elixirforum.com/t/testing-macro-exception/7105
defmodule CompileTimeAssertions do
  defmodule DidNotRaise, do: defstruct(message: nil)

  defmacro assert_compile_time_raise(expected_exception, quoted) do
    actual_exception =
      try do
        Module.eval_quoted(__MODULE__, quoted)
        %DidNotRaise{}
      rescue
        exception ->
          exception
      end

    quote do
      assert unquote(actual_exception.__struct__) === unquote(expected_exception)
    end
  end
end
