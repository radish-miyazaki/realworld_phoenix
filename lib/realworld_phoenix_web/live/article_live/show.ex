defmodule RealworldPhoenixWeb.ArticleLive.Show do
  use RealworldPhoenixWeb, :live_view

  alias RealworldPhoenix.Blogs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:article, Blogs.get_article!(id))}
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"
end
