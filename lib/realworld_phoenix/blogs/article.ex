defmodule RealworldPhoenix.Blogs.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldPhoenix.Blogs.ArticleTag
  alias RealworldPhoenix.Blogs.Comment
  alias RealworldPhoenix.Blogs.Tag

  schema "articles" do
    field :title, :string
    field :body, :string
    has_many :comments, Comment, on_delete: :delete_all

    many_to_many :tags, Tag,
      join_through: ArticleTag,
      # 記事とタグの関連付けが変更された際に、関連付けが外れた中間テーブルを削除する
      on_replace: :delete,
      # 記事が削除された際に、関連する中間テーブルを削除する
      on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs, tags \\ []) do
    article
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> put_assoc(:tags, tags)
  end
end
