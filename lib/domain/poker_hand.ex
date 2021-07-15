defmodule PokerHand do
  use EnumType

  defstruct ranking: Ranking, cards: []

  defenum Ranking do
    value HighCard, 1 do
      def to_string, do: "High Card"
    end

    value Pair, 2 do
      def to_string, do: "Pair"
    end

    value TwoPairs, 3 do
      def to_string, do: "Two Pairs"
    end

    value ThreeOfAKind, 4 do
      def to_string, do: "Three Of A Kind"
    end

    value Straight, 5 do
      def to_string, do: "Straight"
    end

    value Flush, 6 do
      def to_string, do: "Flush"
    end

    value FullHouse, 7 do
      def to_string, do: "Full House"
    end

    value FourOfAKind, 8 do
      def to_string, do: "Four Of A Kind"
    end

    value StraightFlush, 9 do
      def to_string, do: "Straight Flush"
    end
  end

  def find_ranking(cards) do
    case find_by_sequence(cards) do
      false ->
        find_by_frequency(cards)

      ranking ->
        ranking
    end
  end

  defp find_by_frequency(cards) do
    feq = cards |> Card.sort_cards() |> frequencies()
    occurrences = Map.values(feq)

    case occurrences do
      [4, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.FourOfAKind, cards: cards}

      [1, 4] ->
        %PokerHand{ranking: PokerHand.Ranking.FourOfAKind, cards: cards}

      [3, 2] ->
        %PokerHand{ranking: PokerHand.Ranking.FullHouse, cards: cards}

      [2, 3] ->
        %PokerHand{ranking: PokerHand.Ranking.FullHouse, cards: cards}

      [3, 1, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.ThreeOfAKind, cards: cards}

      [1, 3, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.ThreeOfAKind, cards: cards}

      [1, 1, 3] ->
        %PokerHand{ranking: PokerHand.Ranking.ThreeOfAKind, cards: cards}

      [2, 2, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.TwoPairs, cards: cards}

      [2, 1, 2] ->
        %PokerHand{ranking: PokerHand.Ranking.TwoPairs, cards: cards}

      [1, 2, 2] ->
        %PokerHand{ranking: PokerHand.Ranking.TwoPairs, cards: cards}

      [2, 1, 1, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.Pair, cards: cards}

      [1, 2, 1, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.Pair, cards: cards}

      [1, 1, 2, 1] ->
        %PokerHand{ranking: PokerHand.Ranking.Pair, cards: cards}

      [1, 1, 1, 2] ->
        %PokerHand{ranking: PokerHand.Ranking.Pair, cards: cards}

      _ ->
        %PokerHand{ranking: PokerHand.Ranking.HighCard, cards: cards}
    end
  end

  defp find_by_sequence(cards) do
    case is_straight_flush?(cards) do
      true ->
        %PokerHand{ranking: PokerHand.Ranking.StraightFlush, cards: cards}

      false ->
        case is_straight?(cards) do
          true ->
            %PokerHand{ranking: PokerHand.Ranking.Straight, cards: cards}

          false ->
            case is_flush?(cards) do
              true -> %PokerHand{ranking: PokerHand.Ranking.Flush, cards: cards}
              _ -> false
            end
        end
    end
  end

  defp is_straight_flush?(cards) do
    is_flush?(cards) && is_straight?(cards)
  end

  defp is_flush?([head | tail]) do
    is_flush?(tail, head)
  end

  defp is_flush?([head | tail], prev) do
    if(head.suit == prev.suit) do
      is_flush?(tail, head)
    else
      false
    end
  end

  defp is_flush?([], _prev) do
    true
  end

  defp is_straight?(cards) do
    ordered = cards |> Card.sort_cards()
    [head | tail] = ordered

    is_straight?(tail, head)
  end

  defp is_straight?([head | tail], prev) do
    if head.value.value_of == prev.value.value_of + 1 do
      is_straight?(tail, head)
    else
      false
    end
  end

  defp is_straight?([], _prev) do
    true
  end

  def frequencies(cards) do
    Enum.reduce(cards, %{}, fn c, acc -> Map.update(acc, c.value, 1, fn v -> v + 1 end) end)
  end
end
