defmodule DealerTest do
  use ExUnit.Case

  describe "check_winner returns a winner by higher rank" do
    test "StraightFlush beats FourOfAKind, dealer wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Four, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Five, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamons}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.StraightFlush, cards: dealer}

      assert Dealer.check_winner(player, dealer) == {:dealer_wins, expected_ranking}
    end

    test "FourOfAKind beats FullHouse, dealer wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamons}
      ]

      player = [
        %Card{value: Card.Value.Ace, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.King, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.FourOfAKind, cards: dealer}

      assert Dealer.check_winner(player, dealer) == {:dealer_wins, expected_ranking}
    end

    test "FullHouse beats Flush, player wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Ace, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.King, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.FullHouse, cards: player}

      assert Dealer.check_winner(player, dealer) == {:player_wins, expected_ranking}
    end

    test "Flush beats Straight, player wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Four, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.Flush, cards: player}

      assert Dealer.check_winner(player, dealer) == {:player_wins, expected_ranking}
    end

    test "Straight beats ThreeOfAKind, dealer wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Four, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.Straight, cards: dealer}

      assert Dealer.check_winner(player, dealer) == {:dealer_wins, expected_ranking}
    end

    test "ThreeOfAKind beats TwoPairs, player wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Three, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Two, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.ThreeOfAKind, cards: player}

      assert Dealer.check_winner(player, dealer) == {:player_wins, expected_ranking}
    end

    test "TwoPairs beats Pair, dealer wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Three, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.TwoPairs, cards: dealer}

      assert Dealer.check_winner(player, dealer) == {:dealer_wins, expected_ranking}
    end

    test "Pair beats HighCard, player wins" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ten, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Diamonds},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      expected_ranking = %PokerHand{ranking: PokerHand.Ranking.Pair, cards: player}

      assert Dealer.check_winner(player, dealer) == {:player_wins, expected_ranking}
    end
  end

  describe "check_winner checks for a winner by higher card, when a tie happens" do
    test "player and dealer have the same rank in hand, dealer wins by higher card value" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Two, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Two, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Spades}
      ]

      player = [
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Three, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Diamonds}
      ]

      assert Dealer.check_winner(player, dealer) ==
               {:dealer_wins_high_card, %Card{value: Card.Value.Ace, suit: Card.Suit.Hearts}}
    end

    test "player and dealer have the same rank in hand, player wins by higher card value" do
      dealer = [
        %Card{value: Card.Value.Ten, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.Queen, suit: Card.Suit.Spades},
        %Card{value: Card.Value.King, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Nine, suit: Card.Suit.Diamonds}
      ]

      player = [
        %Card{value: Card.Value.Ten, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Jack, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Queen, suit: Card.Suit.Clubs},
        %Card{value: Card.Value.King, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Ace, suit: Card.Suit.Spades}
      ]

      assert Dealer.check_winner(player, dealer) ==
               {:player_wins_high_card, %Card{value: Card.Value.Ace, suit: Card.Suit.Spades}}
    end
  end

  describe "check_winner can't find a winner" do
    test "returns :tie when both hands are identical" do
      dealer = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Three, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Four, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Five, suit: Card.Suit.Hearts},
        %Card{value: Card.Value.Six, suit: Card.Suit.Hearts}
      ]

      player = [
        %Card{value: Card.Value.Two, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Three, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Four, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Five, suit: Card.Suit.Spades},
        %Card{value: Card.Value.Six, suit: Card.Suit.Spades}
      ]

      assert Dealer.check_winner(player, dealer) == :tie
    end
  end
end
