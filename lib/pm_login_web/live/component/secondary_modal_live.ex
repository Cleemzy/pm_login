defmodule PmLoginWeb.LiveComponent.SecondaryModalLive do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form
  import PmLoginWeb.ErrorHelpers

  @defaults %{
    left_button: "Cancel",
    left_button_action: nil,
    left_button_param: nil,
    right_button: "OK",
    right_button_action: nil,
    right_button_param: nil
  }

  # render modal
  @spec render(map()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <div id="modal-<%= @id %>">
      <!-- Modal Background -->
      <div class="modal-container"
          phx-hook="ScrollLock">
        <div class="modal-inner-container">
          <div class="modal-card-task">
            <div class="modal-inner-card">
              <!-- Title -->
              <%= if @title != nil do %>
              <div class="modal-title">
                <%= @title %>
              </div>
              <% end %>

              <!-- Body -->
              <%= if @body != nil do %>
              <div class="modal-body">
                <%= @body %>
              </div>
              <% end %>

              <!-- MY FORM -->
              <div class="modal-body">
                <%= f = form_for @task_changeset, "#", [phx_submit: :submit_secondary] %>
                  <%= label f, "Tâche" %>
                  <%= text_input f, :title %>
                  <%= error_tag f, :title %>
                  <%= hidden_input f, :project_id, value: @pro_id %>
                  <%= hidden_input f, :contributor_id, value: @curr_user_id %>
                  <div class="row">
                    <div class="column">
                      <%= label f, "Date de début" %>
                      <%= date_input f, :date_start %>
                      <%= error_tag f, :date_start %>
                      <%= error_tag f, :date_start_lt %>
                    </div>

                    <div class="column">
                      <%= label f, "Date finale" %>
                      <%= date_input f, :date_end %>
                      <%= error_tag f, :date_end %>
                      <%= error_tag f, :date_end_lt %>
                      <%= error_tag f, :dt_end_lt_start %>
                    </div>
                  </div>
                  <div class="row">
                    <div class="column">
                      <%= label f, "Durée estimée (en heure(s))" %>
                      <%= number_input f, :estimated_duration %>
                      <%= error_tag f, :estimated_duration %>
                      <%= error_tag f, :negative_estimated %>
                    </div>
                    <div class="column">
                    <%= label f, "Tâche mère" %>
                    <%= select f, :parent_id, @primaries %>
                    <%= error_tag f, :parent_id %>
                    </div>
                  </div>

                  <!-- Buttons -->
                  <div class="modal-buttons">
                    <!-- Left Button -->
                    <button class="left-button"
                            type="button"
                            phx-click="left-button-click"
                            phx-target="#modal-<%= @id %>">
                      <div>
                        <%= @left_button %>
                      </div>
                    </button>
                      <div class="right-button">
                      <%= submit "Créer tâche" %>
                      </div>
                  </div>



                </form>

              </div>


            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{id: _id} = assigns, socket) do
    {:ok, assign(socket, Map.merge(@defaults, assigns))}
  end

  # Fired when user clicks right button on modal
  def handle_event(
        "right-button-click",
        _params,
        %{
          assigns: %{
            right_button_action: right_button_action,
            right_button_param: right_button_param
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_clicked, %{action: right_button_action, param: right_button_param}}
    )

    {:noreply, socket}
  end

  def handle_event(
        "left-button-click",
        _params,
        %{
          assigns: %{
            left_button_action: left_button_action,
            left_button_param: left_button_param
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_clicked, %{action: left_button_action, param: left_button_param}}
    )

    {:noreply, socket}
  end
end
