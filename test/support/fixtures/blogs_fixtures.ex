defmodule RealworldPhoenix.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealworldPhoenix.Blogs` context.
  """

  import RealworldPhoenix.AccountsFixtures

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title",
        author_id: user_fixture().id
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
        article_id: article_fixture().id,
        author_id: user_fixture().id
      })
      |> RealworldPhoenix.Blogs.create_comment()

    comment
  end

  @doc """
  Generate a unique tag tag.
  """
  def unique_tag_tag, do: "some tag#{System.unique_integer([:positive])}"

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        tag: unique_tag_tag()
      })
      |> RealworldPhoenix.Blogs.create_tag()

    tag
  end
end
