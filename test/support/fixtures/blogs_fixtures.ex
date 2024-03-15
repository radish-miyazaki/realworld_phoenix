defmodule RealworldPhoenix.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealworldPhoenix.Blogs` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> RealworldPhoenix.Blogs.create_article()

    article
  end
end
