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

  describe "find_ranking scenario" do
    test "If all cards belong to a sequence AND have the same Suit, returns a StraightFlush" do
      straight_flush = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Four, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Five, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(straight_flush) == %PokerHand{
               ranking: PokerHand.Ranking.StraightFlush,
               cards: straight_flush
             }
    end

    test "If four cards have the same value, returns FourOfAKind" do
      four_of_a_kind = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamons}
      ]

      assert PokerHand.find_ranking(four_of_a_kind) == %PokerHand{
               ranking: PokerHand.Ranking.FourOfAKind,
               cards: four_of_a_kind
             }
    end

    test "If the hand has 3 cards of same value and a pair, returns a FullHouse" do
      full_house = [
        %Card{value: Card.Value.Ace, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.King, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(full_house) == %PokerHand{
               ranking: PokerHand.Ranking.FullHouse,
               cards: full_house
             }
    end

    test "If all cards have the same Suit, returns a Flush" do
      flush = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(flush) == %PokerHand{
               ranking: PokerHand.Ranking.Flush,
               cards: flush
             }
    end

    test "If all cards belong to a sequence, returns a Straight" do
      straight = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Four, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(straight) == %PokerHand{
               ranking: PokerHand.Ranking.Straight,
               cards: straight
             }
    end

    test "If three cards have the same value, returns ThreeOfAKind" do
      three_of_a_kind = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(three_of_a_kind) == %PokerHand{
               ranking: PokerHand.Ranking.ThreeOfAKind,
               cards: three_of_a_kind
             }
    end

    test "If there are two pairs of same value, returns TwoPairs" do
      two_pairs = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Three, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(two_pairs) == %PokerHand{
               ranking: PokerHand.Ranking.TwoPairs,
               cards: two_pairs
             }
    end

    test "If there is only one Pair of same value, returns Pair" do
      pair = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(pair) == %PokerHand{
               ranking: PokerHand.Ranking.Pair,
               cards: pair
             }
    end

    test "If no combination is found, returns HighCard" do
      high_card = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ten, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      assert PokerHand.find_ranking(high_card) == %PokerHand{
               ranking: PokerHand.Ranking.HighCard,
               cards: high_card
             }
    end
  end
end
