defmodule RealTimeWeb.WrongLive do
  use RealTimeWeb, :live_view
  def mount(_param, _session, socket) do

    {:ok, assign(socket, message: "Guess a number", score: 0, guess: nil)}

  end
  def render(assigns) do
    ~H"""
      <div class="text-center">
      <h1>Your score: <%= @score %></h1>
      <h2>
      <div class="mt-4 mb-4"> <%= @message %></div>

      </h2>
      <h2>
      <%= for n <- 1..10 do %>
      <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
      </h2>
      </div>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do

    rnd = Enum.random(1..10)
    guess = String.to_integer(guess)


    case rnd - guess do

    0 ->
      message = "You guess right, you guess #{guess}"
      score = socket.assigns.score + 10
      #time = time()
      {:noreply, assign(socket, message: message, score: score, guess: guess)}
    _ ->

      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1
      #time = time()
      {:noreply, assign(socket, message: message, score: score, guess: guess)}
    end
end

 # def time do
  #  {:ok, datetime} = DateTime.now("Asia/Kuala_Lumpur")
   # datetime |> to_string |> String.slice(0, 24)

 # end
end
