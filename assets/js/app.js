// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"
// import "require.js"


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"


// Define hooks
const Hooks = {}

Hooks.Board = {
  mounted() {
    this.initDraggables();
  },

  updated() {
    this.sortableCard.destroy();
    this.sortableStage.destroy();
    this.initDraggables();
  },

  initDraggables() {
    this.sortableCard = new Sortable(
      document.querySelectorAll(".stage__cards"),
      {
        draggable: ".card",
        mirror: {
          constrainDimensions: true
        },
        swapAnimation: {
          duration: 200,
          easingFunction: "ease-in-out"
        },
        plugins: [Plugins.SwapAnimation]
      }
    );

    this.sortableCard.on("sortable:stop", event => {
      const source = event.data.dragEvent.data.source;
      const cardId = parseInt(source.getAttribute("data-card-id"));
      const newStageId = parseInt(
        event.data.newContainer.getAttribute("data-stage-id")
      );
      const newIndex = parseInt(event.data.newIndex);
      const cardPayload = {
        card: {
          id: cardId,
          stage_id: newStageId,
          position: newIndex
        }
      };
      this.pushEvent("update_card", cardPayload);
    });

    this.sortableStage = new Sortable(document.querySelectorAll(".board"), {
      draggable: ".stage",
      handle: ".draggable-handle",
      mirror: {
        constrainDimensions: true,
        yAxis: false
      }
    });

    this.sortableStage.on("sortable:stop", event => {
      const source = event.data.dragEvent.data.source;
      const stageId = parseInt(source.getAttribute("data-stage-id"));
      const newIndex = parseInt(event.data.newIndex);
      const stagePayload = {
        stage: {
          id: stageId,
          position: newIndex
        }
      };
      this.pushEvent("update_stage", stagePayload);
    });
  }
};

Hooks.ScrollLock = {
  mounted() {
    this.lockScroll()
  },
  destroyed() {
    this.unlockScroll()
  },
  lockScroll() {
    // From https://github.com/excid3/tailwindcss-stimulus-components/blob/master/src/modal.js
    // Add right padding to the body so the page doesn't shift when we disable scrolling
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth
    document.body.style.paddingRight = `${scrollbarWidth}px`
    // Save the scroll position
    this.scrollPosition = window.pageYOffset || document.body.scrollTop
    // Add classes to body to fix its position
    document.body.classList.add('fix-position')
    // Add negative top position in order for body to stay in place
    document.body.style.top = `-${this.scrollPosition}px`
  },
  unlockScroll() {
    // From https://github.com/excid3/tailwindcss-stimulus-components/blob/master/src/modal.js
    // Remove tweaks for scrollbar
    document.body.style.paddingRight = null
    // Remove classes from body to unfix position
    document.body.classList.remove('fix-position')
    // Restore the scroll position of the body before it got locked
    document.documentElement.scrollTop = this.scrollPosition
    // Remove the negative top inline style from body
    document.body.style.top = null
  }
};
//hook end

let navToggle = document.querySelector(".nav__toggle");
let navWrapper = document.querySelector(".nav__wrapper");
navToggle.addEventListener("click", function () {
  if (navWrapper.classList.contains("active")) {
    this.setAttribute("aria-expanded", "false");
    this.setAttribute("aria-label", "menu");
    navWrapper.classList.remove("active");
  } else {
    navWrapper.classList.add("active");
    this.setAttribute("aria-label", "close menu");
    this.setAttribute("aria-expanded", "true");
  }
});

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
//Working liveSocket
// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
let liveSocket = new LiveSocket("/live", Socket, {
  params: {
    _csrf_token: csrfToken
  },
  hooks: Hooks
});

liveSocket.connect()
