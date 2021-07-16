defmodule Card do
  use EnumType

  defstruct value: Value, suit: Suit

  defenum Value do
    value Two, "2" do
      def value_of, do: 2
    end

    value Three, "3" do
      def value_of, do: 3
    end

    value Four, "4" do
      def value_of, do: 4
    end

    value Five, "5" do
      def value_of, do: 5
    end

    value Six, "6" do
      def value_of, do: 6
    end

    value Seven, "7" do
      def value_of, do: 7
    end

    value Eight, "8" do
      def value_of, do: 8
    end

    value Nine, "9" do
      def value_of, do: 9
    end

    value Ten, "T" do
      def value_of, do: 10
    end

    value Jack, "J" do
      def value_of, do: 11
    end

    value Queen, "Q" do
      def value_of, do: 12
    end

    value King, "K" do
      def value_of, do: 13
    end

    value Ace, "A" do
      def value_of, do: 14
    end
  end

  defenum Suit do
    value(Hearts, "H")
    value(Spades, "S")
    value(Diamonds, "D")
    value(Clubs, "C")
  end

  def sort_cards(cards) when is_list(cards) do
    Enum.sort(cards, fn c, n -> c.value.value_of <= n.value.value_of end)
  end

  def high_card(cards) when is_list(cards) do
    Enum.max(cards, fn c, n -> c.value.value_of >= n.value.value_of end)
  end

  def cards_to_string(cards) when is_list(cards) do
    cards |> Enum.map(fn c -> card_to_string(c) end)
  end

  def card_to_string(%Card{value: v, suit: s}) do
    v.value <> s.value
  end

  def card_from_string(card) when is_binary(card) do
    card |> check_length |> check_value |> check_suit |> to_card
  end

  def cards_from_string(cards) when is_binary(cards) do
    cards |> String.split() |> Enum.map(fn s -> card_from_string(s) end)
  end

  def valid_cards?(cards) do
    cards |> cards_from_string() |> Enum.all?(fn c -> is_card?(c) end) &&
      cards |> String.split() |> Enum.count() == 5
  end

  defp check_length(string) do
    case String.length(string) != 2 do
      true -> :invalid_length
      false -> String.split(string, "", trim: true)
    end
  end

  defp check_value(error) when is_atom(error) do
    error
  end

  defp check_value([head | _tail] = card) do
    case Enum.find(Card.Value.values(), false, fn r -> r == head end) do
      false -> :invalid_value
      _ -> card
    end
  end

  defp check_suit(error) when is_atom(error) do
    error
  end

  defp check_suit([_head | tail] = card) do
    [suit | []] = tail

    case Enum.find(Card.Suit.values(), false, fn r -> r == suit end) do
      false -> :invalid_suit
      _ -> card
    end
  end

  defp to_card([value | tail]) do
    [suit | []] = tail
    %Card{value: Card.Value.from(value), suit: Card.Suit.from(suit)}
  end

  defp to_card(error) when is_atom(error) do
    error
  end

  defp is_card?(%Card{value: _v, suit: _s}) do
    true
  end

  defp is_card?(_any) do
    false
  end
end
