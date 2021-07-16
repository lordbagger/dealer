defmodule DealerTest do
  use ExUnit.Case

  @straight_flush "2H 3H 4H 5H 6H"
  @four_of_a_kind "7H 7C 7D 7S 5D"
  @full_house "AS AH AC KS KH"
  @flush "2C 3C 6C JC QC"
  @straight "2D 3D 4S 5D 6D"
  @three_of_a_kind "8H 8C 8D 5S 6S"
  @two_pairs "9H 9C TD TS JD"
  @pair "TC TH QD KC AH"
  @high_card "AC KD QH 5C 3S"

  @higher_straight "9D TS JS QS KC"

  describe "check_winner returns a winner by higher rank" do
    test "StraightFlush beats FourOfAKind, white wins" do
      black = @straight_flush

      white = @four_of_a_kind

      expected_ranking = "Straight Flush"

      assert Dealer.check_winner(black, white) == "Black wins - #{expected_ranking}"
    end

    test "FourOfAKind beats FullHouse, black wins" do
      black = @four_of_a_kind

      white = @full_house

      expected_ranking = "Four Of A Kind"

      assert Dealer.check_winner(black, white) == "Black wins - #{expected_ranking}"
    end

    test "FullHouse beats Flush, white wins" do
      black = @flush

      white = @full_house

      expected_ranking = "Full House"

      assert Dealer.check_winner(black, white) == "White wins - #{expected_ranking}"
    end

    test "Flush beats Straight, white wins" do
      black = @straight

      white = @flush

      expected_ranking = "Flush"

      assert Dealer.check_winner(black, white) == "White wins - #{expected_ranking}"
    end

    test "Straight beats ThreeOfAKind, black wins" do
      black = @straight

      white = @three_of_a_kind

      expected_ranking = "Straight"

      assert Dealer.check_winner(black, white) == "Black wins - #{expected_ranking}"
    end

    test "ThreeOfAKind beats TwoPairs, white wins" do
      black = @two_pairs

      white = @three_of_a_kind

      expected_ranking = "Three Of A Kind"

      assert Dealer.check_winner(black, white) == "White wins - #{expected_ranking}"
    end

    test "TwoPairs beats Pair, black wins" do
      black = @two_pairs

      white = @pair

      expected_ranking = "Two Pairs"

      assert Dealer.check_winner(black, white) == "Black wins - #{expected_ranking}"
    end

    test "Pair beats HighCard, white wins" do
      black = @high_card

      white = @pair

      expected_ranking = "Pair"

      assert Dealer.check_winner(black, white) == "White wins - #{expected_ranking}"
    end
  end

  describe "check_winner checks for a winner by higher card, when a tie happens" do
    test "black and white have the same rank in hand, black wins by higher card value" do
      black = @higher_straight

      white = @straight

      expected_high_card = "KC"

      assert Dealer.check_winner(black, white) ==
               "Black wins - High Card: #{expected_high_card}"
    end

    test "black and white have the same rank in hand, white wins by higher card value" do
      black = @straight

      white = @higher_straight

      expected_high_card = "KC"

      assert Dealer.check_winner(black, white) ==
               "White wins - High Card: #{expected_high_card}"
    end
  end

  describe "check_winner can't find a winner" do
    test "returns :tie when both hands are identical" do
      black = @flush

      white = @flush

      assert Dealer.check_winner(black, white) == "TIE"
    end
  end
end
