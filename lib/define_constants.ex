defmodule DefineConstants do
  @moduledoc """
  Elixir library to provide constants functionality.

  ## Usage

  DefineConstants provides the `define` macro to create custom constants. Constants should live inside their own modules.

      defmodule MyConstants do
        use DefineConstants

        define(:name, "MyApplication")
        define(:number, 7)
      end

  The `define` macro takes atom keys and arbitrary values. The provided key/value pairs are used to create the `constant` macro.

  Caller functions use the `constant` macro to retrieve the constant values.

      defmodule Caller do
        import MyConstants

        constant(:name)
        constant(:number) + 10
      end

  Since `constant` is a macro, at compile time, all `constant` calls are converted to their appropriate values.
  """

  @doc false
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :define_constants, accumulate: true)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro define(key, value) when is_atom(key) do
    quote do
      @define_constants {unquote(key), unquote(value)}
    end
  end

  defmacro define(key, _value) do
    raise(ArgumentError, message: "first argument \"#{Macro.to_string(key)}\" is not an atom")
  end

  @doc false
  defmacro __before_compile__(_environment) do
    quote do
      for {key, value} <- @define_constants do
        Module.eval_quoted(
          __MODULE__,
          quote do
            defmacro constant(unquote(key)) do
              unquote(value)
            end
          end
        )
      end

      defmacro constant(key) when is_atom(key) do
        raise(ArgumentError, message: "key \"#{Macro.to_string(key)}\" is not defined")
      end

      defmacro constant(key) do
        raise(ArgumentError, message: "key \"#{Macro.to_string(key)}\" is not an atom")
      end
    end
  end
end
