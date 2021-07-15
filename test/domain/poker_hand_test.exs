defmodule PokerHandTest do
  use ExUnit.Case

  describe "PokerHand.Ranking functions and values" do
    test "to_string returns the correct String representation for each PokerHand.Ranking" do
      rankings = PokerHand.Ranking.enums()

      assert Enum.map(rankings, fn r -> r.to_string() end) ==
               [
                 "High Card",
                 "Pair",
                 "Two Pairs",
                 "Three Of A Kind",
                 "Straight",
                 "Flush",
                 "Full House",
                 "Four Of A Kind",
                 "Straight Flush"
               ]
    end

    test "value() returns the expected ordered Integer value" do
      assert PokerHand.Ranking.HighCard.value() == 1
      assert PokerHand.Ranking.Pair.value() == 2
      assert PokerHand.Ranking.TwoPairs.value() == 3
      assert PokerHand.Ranking.ThreeOfAKind.value() == 4
      assert PokerHand.Ranking.Straight.value() == 5
      assert PokerHand.Ranking.Flush.value() == 6
      assert PokerHand.Ranking.FullHouse.value() == 7
      assert PokerHand.Ranking.FourOfAKind.value() == 8
      assert PokerHand.Ranking.StraightFlush.value() == 9
    end
  end
end
