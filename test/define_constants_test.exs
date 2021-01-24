defmodule DefineConstantsTest do
  use ExUnit.Case
  import CompileTimeAssertions
  doctest DefineConstants

  defmodule Constants do
    use DefineConstants

    define(:a, 1)
    define(:b, "two")
  end

  test "constant macro provides correct values" do
    import Constants

    assert constant(:a) === 1
    assert constant(:b) === "two"
  end

  test "define macro raises error with non-atom key" do
    assert_compile_time_raise(ArgumentError, fn ->
      defmodule Testing do
        use DefineConstants

        define(1, 1)
      end
    end)
  end

  test "constant raises error with non-atom key" do
    assert_compile_time_raise(ArgumentError, fn ->
      defmodule Testing do
        import Constants

        constant(1)
      end
    end)
  end

  test "constant raises error with undefined key" do
    assert_compile_time_raise(ArgumentError, fn ->
      defmodule Testing do
        import Constants

        constant(:c)
      end
    end)
  end
end
