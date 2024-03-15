defmodule RealworldPhoenix.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldPhoenix.Blogs.Article

  schema "comments" do
    field :body, :string
    belongs_to :article, Article

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :article_id])
    |> validate_required([:body, :article_id])
  end
end
