defmodule PmLoginWeb.LiveComponent.CommentsModalLive do
  @moduledoc """
  This is a general modal component with title, body text, and two buttons.

  A required action string and optional parameter are provided for each
  button when the modal is initialized. These will be returned to the caller
  when the corresponding button is clicked.

  The caller must have message handlers defined for each button that takes
  the given action and parameter for each button. For example:

      def handle_info(
        {ModalLive, :button_clicked, %{action: "delete", param: item_id}},
        socket
      )

  This is a stateful component, so you MUST specify an id when calling
  live_component.

  The component can be called like:

      <%= live_component(@socket,
                         ModalLive,
                         id: "confirm-boom",
                         title: "Go Boom?",
                         body: "Are you sure you want to crash the counter?",
                         right_button: "OK",
                         right_button_action: "crash",
                         right_button_param: "boom",
                         left_button: "Cancel",
                         left_button_action: "cancel-boom",
                         left_button_param: nil)
      %>
  """
  use Phoenix.LiveComponent

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
          <div class="modal-card-comments">
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

              <div class="modal-body">


                <div class="row">
                  <div class="comments-section">
                    <div class="basecontents__without__shadow comment__div">

                      <div class="row comment__header">
                        <div class="column column-20"><div class="row"><img class="pp__comment" src="" /><p class="username__comment">Utilisateur</p></div></div>
                        <div class="column column-80"></div>
                      </div>

                      <div class="row">
                        <i class="bi bi-caret-right-fill"></i>
                        <div class="comment__content">
                          <p class="textc__content"> contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent</p>
                        </div>
                      </div>

                      <div class="row comment__footer">
                        <div class="column column-70">
                        </div>
                        <div class="column column-30">
                          <i class="date__footer">footer</i>
                        </div>
                      </div>

                    </div>

                    <div class="basecontents__without__shadow comment__div">

                      <div class="row comment__header">
                        <div class="column column-20"><div class="row"><img class="pp__comment" src="" /><p class="username__comment">Utilisateur</p></div></div>
                        <div class="column column-80"></div>
                      </div>

                      <div class="row">
                        <i class="bi bi-caret-right-fill"></i>
                        <div class="comment__content">
                          <p class="textc__content"> contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent</p>
                        </div>
                      </div>

                      <div class="row comment__footer">
                        <div class="column column-70">
                        </div>
                        <div class="column column-30">
                          <i class="date__footer">footer</i>
                        </div>
                      </div>

                    </div>

                    <div class="basecontents__without__shadow comment__div">

                      <div class="row comment__header">
                        <div class="column column-20"><div class="row"><img class="pp__comment" src="" /><p class="username__comment">Utilisateur</p></div></div>
                        <div class="column column-80"></div>
                      </div>

                      <div class="row">
                        <i class="bi bi-caret-right-fill"></i>
                        <div class="comment__content">
                          <p class="textc__content"> contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent</p>
                        </div>
                      </div>

                      <div class="row comment__footer">
                        <div class="column column-70">
                        </div>
                        <div class="column column-30">
                          <i class="date__footer">footer</i>
                        </div>
                      </div>

                    </div>
                  </div>
                </div>




              </div>

              <!-- Buttons -->
              <div class="row comment__modal__footer">

                <!-- Left Button -->
                <div class="column">
                  <i class="bi bi-arrow-bar-left comment__back" phx-click="left-button-click" phx-target="#modal-<%= @id %>"></i>
                </div>
                <!-- Right Button -->
                <div class="column">
                  <input type="text" name="com">
                </div>
                <div class="column">
                  <input type="submit">
                </div>


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
