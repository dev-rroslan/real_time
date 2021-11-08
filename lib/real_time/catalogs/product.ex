defmodule RealTime.Catalogs.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :avalability, :integer
    field :name, :string
    field :price, :integer
    field :sku, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :avalability])
    |> validate_required([:name, :price, :sku, :avalability])
  end
end
