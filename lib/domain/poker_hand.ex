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
end
