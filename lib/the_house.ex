defmodule TheHouse do
  use GenServer

  def start() do
    GenServer.start(__MODULE__, :ok, name: TheHouse)
  end

  def check_winner({player_name, player_cards} = player, {dealer_name, dealer_cards} = dealer)
      when is_binary(player_name) and is_binary(dealer_name) and is_list(player_cards) and
             is_list(dealer_cards) do
    GenServer.call(__MODULE__, {:check_winner, player, dealer})
  end

  def stop do
    GenServer.cast(__MODULE__, :stop)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:check_winner, {_, []}, {_, []}}, _from, state) do
    {:reply, "Error: received empty hand from both players", state}
  end

  def handle_call({:check_winner, {player_name, []}, _}, _from, state) do
    {:reply, "Error: received empty hand from #{player_name}", state}
  end

  def handle_call({:check_winner, _, {dealer_name, []}}, _from, state) do
    {:reply, "Error: received empty hand from #{dealer_name}", state}
  end

  def handle_call({:check_winner, player, dealer}, _from, state) do
    {_, player_input} = player
    {_, dealer_input} = dealer

    case Card.valid_cards?(player_input) && Card.valid_cards?(dealer_input) do
      false ->
        values = Card.Value.values()
        suits = Card.Suit.values()

        {:reply,
         "Check your cards! Your hand must contain exactly 5 cards, Suits must be in #{suits}. Values must be in #{
           values
         }", state}

      _ ->
        check_winner(player, dealer, state)
    end
  end

  defp check_winner(player, dealer, state) do
    {player_name, player_input} = player
    {dealer_name, dealer_input} = dealer

    player_cards = Card.cards_from_string(player_input)
    dealer_cards = Card.cards_from_string(dealer_input)

    case Dealer.check_winner(player_cards, dealer_cards) do
      {:player_wins, poker_hand} ->
        {:reply, "#{player_name} wins - #{poker_hand.ranking.to_string}", state}

      {:dealer_wins, poker_hand} ->
        {:reply, "#{dealer_name} wins - #{poker_hand.ranking.to_string}", state}

      {:player_wins_high_card, high_card} ->
        {:reply, "#{player_name} wins - High Card: #{Card.card_to_string(high_card)}", state}

      {:dealer_wins_high_card, high_card} ->
        {:reply, "#{dealer_name} wins - High Card: #{Card.card_to_string(high_card)}", state}

      _ ->
        {:reply, "TIE", state}
    end
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end

  def terminate(reason, stats) do
    IO.puts("Server terminated because of #{reason}")
    inspect(stats)
    :ok
  end
end
