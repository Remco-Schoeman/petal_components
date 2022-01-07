defmodule PetalComponents.Card do
  use Phoenix.Component

  # prop class, :string
  # prop variant, :string
  # slot default
  def card(assigns) do
    assigns = assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:variant, fn -> "basic" end)
      |> assign_new(:inner_block, fn -> nil end)

    ~H"""
    <div class={Enum.join([
      "flex flex-wrap overflow-hidden",
      get_variant_classes(@variant), @class
      ], " ")}>
      <div class={Enum.join([
        "flex flex-col bg-white max-w-full", @class
        ], " ")}>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
    </div>
    """
  end

  # prop class, :string
  # prop src, :string
  def card_media(assigns) do
    assigns = assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:src, fn -> nil end)

    ~H"""
    <div class={Enum.join([
      "flex-shrink-0", @class
      ], " ")}>
      <%= if src_blank?(@src) do %>
        <div class="h-full bg-gray-300">
        </div>
      <% else %>
      <img src={@src} class={Enum.join([
        "object-cover w-full",
        @class
      ], " ")} />
      <% end %>
    </div>
    """
  end

  # prop class, :string
  # prop heading, :string
  # prop category, :string
  # slot default
  def card_content(assigns) do
    assigns = assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign_new(:category, fn -> nil end)
      |> assign_new(:heading, fn -> nil end)

    ~H"""
    <div class={Enum.join([
      "p-6 gap-2", @class
      ], " ")}>
      <%= if @category do %>
        <div class="mb-3 text-sm font-medium text-primary-600">
          <%= @category %>
        </div>
      <% end %>
      <%= if @heading do %>
        <div class="mb-2 text-xl font-medium text-gray-900">
          <%= @heading %>
        </div>
      <% end %>
      <%= if @inner_block do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </div>
    """
  end

  defp src_blank?(src) do
    (!src || src == "")
  end

  defp get_variant_classes(variant) do
    case variant do
      "basic" ->
        "rounded-lg shadow-lg"

      "outline" ->
        "rounded-lg border border-gray-300"
    end
  end
end