defmodule CardTest do
  use ExUnit.Case

  describe "tests Card.Value defenum values and functions" do
    test "given a String representation of a Value, returns the corresponding Card.Value type" do
      assert Card.Value.from("2") == Card.Value.Two
      assert Card.Value.from("3") == Card.Value.Three
      assert Card.Value.from("4") == Card.Value.Four
      assert Card.Value.from("5") == Card.Value.Five
      assert Card.Value.from("6") == Card.Value.Six
      assert Card.Value.from("7") == Card.Value.Seven
      assert Card.Value.from("8") == Card.Value.Eight
      assert Card.Value.from("9") == Card.Value.Nine
      assert Card.Value.from("T") == Card.Value.Ten
      assert Card.Value.from("J") == Card.Value.Jack
      assert Card.Value.from("Q") == Card.Value.Queen
      assert Card.Value.from("K") == Card.Value.King
      assert Card.Value.from("A") == Card.Value.Ace
    end

    test "given a EnumType of Value, returns the corresponding ordered Integer value" do
      assert Card.Value.Two.value_of() == 2
      assert Card.Value.Three.value_of() == 3
      assert Card.Value.Four.value_of() == 4
      assert Card.Value.Five.value_of() == 5
      assert Card.Value.Six.value_of() == 6
      assert Card.Value.Seven.value_of() == 7
      assert Card.Value.Eight.value_of() == 8
      assert Card.Value.Nine.value_of() == 9
      assert Card.Value.Ten.value_of() == 10
      assert Card.Value.Jack.value_of() == 11
      assert Card.Value.Queen.value_of() == 12
      assert Card.Value.King.value_of() == 13
      assert Card.Value.Ace.value_of() == 14
    end
  end

  describe "tests Card.Suit defenum values" do
    test "given a String representation of a Suit, returns the corresponding Card.Suit type" do
      spades = "S"
      hearts = "H"
      clubs = "C"
      diamonds = "D"

      assert Card.Suit.from(spades) == Card.Suit.Spades
      assert Card.Suit.from(hearts) == Card.Suit.Hearts
      assert Card.Suit.from(clubs) == Card.Suit.Clubs
      assert Card.Suit.from(diamonds) == Card.Suit.Diamonds
    end
  end

  describe "given a String representation of a %Card{} " do
    test "returns :invalid_length when length is different from 2" do
      empty = ""
      one_char = "s"
      more_than_one = "ssssssssssss"

      assert Card.from_string(empty) == :invalid_length
      assert Card.from_string(one_char) == :invalid_length
      assert Card.from_string(more_than_one) == :invalid_length
    end

    test "returns :invalid_value when the value is not listed in Card.Value" do
      no_value = "DD"
      assert Card.from_string(no_value) == :invalid_value
    end

    test "returns :invalid_suit when the suit is not listed in Card.Suit" do
      no_suit = "TA"
      assert Card.from_string(no_suit) == :invalid_suit
    end

    test "returns a %Card{}" do
      card = "TS"
      assert Card.from_string(card) == %Card{value: Card.Value.Ten, suit: Card.Suit.Spades}
    end
  end

  describe "given a %Card{}" do
    test "to_string returns it as String" do
      card = %Card{value: Card.Value.Ace, suit: Card.Suit.Spades}
      assert Card.card_to_string(card) == "AS"
    end
  end
end
