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

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        body: "some body",
        article_id: article_fixture().id
      })
      |> RealworldPhoenix.Blogs.create_comment()

    comment
  end
end
