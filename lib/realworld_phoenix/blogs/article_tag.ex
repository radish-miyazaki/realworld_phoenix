defmodule RealworldPhoenix.Blogs.ArticleTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldPhoenix.Blogs.Article
  alias RealworldPhoenix.Blogs.Tag

  @primary_key false
  schema "article_tags" do
    belongs_to :article, Article
    belongs_to :tag, Tag
  end

  @doc false
  def changeset(article_tag, attrs) do
    article_tag
    |> cast(attrs, [:tag_id, :article_id])
    |> validate_required([:tag_id, :article_id])
  end
end
