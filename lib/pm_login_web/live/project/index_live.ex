defmodule PmLoginWeb.Project.IndexLive do
  use Phoenix.LiveView
  alias PmLoginWeb.ProjectView
  alias PmLogin.Monitoring

  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    {:ok, socket |> assign(projects: Monitoring.list_projects(), curr_user_id: curr_user_id), layout: {PmLoginWeb.LayoutView, "board_layout_live.html"}}
  end

  def handle_event("switch-notif", %{}, socket) do
    IO.puts "switched"
    {:noreply, socket}
  end
  
  def render(assigns) do
    ProjectView.render("index.html", assigns)
  end
end
