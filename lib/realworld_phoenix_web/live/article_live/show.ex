defmodule RealworldPhoenixWeb.ArticleLive.Show do
  use RealworldPhoenixWeb, :live_view

  alias RealworldPhoenix.Blogs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    article = Blogs.get_article!(id)
    %{live_action: action, current_user: user} = socket.assigns

    if action == :edit && article.author.id != user.id do
      {:noreply, push_navigate(socket, to: ~p"/articles/#{article}")}
    else
      {:noreply,
       socket
       |> assign(:page_title, page_title(socket.assigns.live_action))
       |> assign(:article, Blogs.get_article!(id))}
    end
  end

  @impl true
  def handle_event("delete", _params, socket) do
    %{article: article, current_user: user} = socket.assigns

    if article.author.id != user.id do
      {:noreply, socket}
    else
      {:ok, _} = Blogs.delete_article(article)
      {:noreply, push_navigate(socket, to: ~p"/articles")}
    end
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"
end
