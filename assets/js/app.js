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

require('bootstrap-icons/font/bootstrap-icons.css');
require('material-icons/iconfont/material-icons.css')
// import 'alpinejs'
// import Alpine from 'alpinejs/builds/cdn'

import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"
import { Sortable, Plugins } from "@shopify/draggable";
import Alpine from "alpinejs";
// ScrollComment
let messageBody = document.querySelector('#messageBody');
// messageBody.scrollTop = messageBody.scrollHeight - messageBody.clientHeight;

// window.Alpine = Alpine
// console.log(window.Alpine)
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

// Hooks.ScrollLock = {
//   mounted() {
//     this.lockScroll()
//   },
//   destroyed() {
//     this.unlockScroll()
//   },
//   lockScroll() {
//     const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth
//     document.body.style.paddingRight = `${scrollbarWidth}px`
//     this.scrollPosition = window.pageYOffset || document.body.scrollTop
//     document.body.classList.add('fix-position')
//     document.body.style.top = `-${this.scrollPosition}px`
//   },
//   unlockScroll() {
//     document.body.style.paddingRight = null
//     document.body.classList.remove('fix-position')
//     document.documentElement.scrollTop = this.scrollPosition
//     document.body.style.top = null
//   }
// };

  Hooks.AnimateAlert = {
  mounted(){
  // console.log("tafiditra alert")
   this.handleEvent("AnimateAlert", ({}) =>
     this.reset_opacity()
   )
 },
 updated() {

 },
 reset_opacity(){
   var alert = document.querySelector("#alert_anim");
   alert.style.opacity = 1;
   window.setTimeout(function(){alert.style.opacity = 0;}, 2000);
 },
 anim_onload(){
   var alerts = document.querySelectorAll(".alert");
  //  console.log(alerts);

   alerts.forEach(item => {
     item.style.opacity = 1
     item.onload = window.setTimeout(function(){item.style.opacity = 0;}, 2000);
   })

   ;

 for (var i = 0; i < alerts.length; i++) {
   alerts[i].style.opacity = 1
   alerts[i].onload = window.setTimeout(function(){alerts[i].style.opacity = 0;}, 2000);
 }

    /*
    var alert = document.querySelector("#alert_anim");
    console.log(alert)
    alert.style.opacity = 1;
    alert.onload = window.setTimeout(function(){alert.style.opacity = 0;}, 2000);

    */

    /*
    var alert = document.querySelectorAll(".alert");
    console.log(alert)
    for (var i = 0; i < alert.length; i++) {
    alert[i]
    alert[i].style.opacity = 1;
    alert[i].style.backgroundColor = "purple";

    */

     }

 };

Hooks.blurHook = {
  mounted(){
    // console.log("tafiditra blurHook")
    this.handleEvent("blurBody", ({param1,param2}) =>
      // console.log(param1)
      this.blurBody()
    )
  },
  blurBody(){
    var body = document.body;
    var request_form = document.querySelector("#the_request_form");
    // console.log(request_form);

    // console.log(body);
    body.style.opacity = 0.5;

    // var modal = document.querySelector(".modal-container");
    // console.log(modal);
    // modal.style.filter = "blur(1px)";
    request_form.style.opacity = 1;

  }
}

Hooks.MessageBody = {
  mounted(){
    var messageBody = document.querySelector('#messageBody');
    this.handleEvent("updateScroll", ({}) =>
    messageBody.scrollTop = messageBody.scrollHeight - messageBody.clientHeight
  )
 }
//  updated(){
//    var messageBody = document.querySelector('#messageBody');
//    this.handleEvent("updateScroll", ({}) =>
//    messageBody.scrollTop = messageBody.scrollHeight - messageBody.clientHeight
//   )
// },
  // beforeUpdate(){
  //   var messageBody = document.querySelector('#messageBody');
  //   this.handleEvent("updateScroll", ({}) =>
  //   messageBody.scrollTop = messageBody.scrollHeight - messageBody.clientHeight
  //  )
  // }
};

Hooks.SpinTest = {
  mounted(){
    // console.log("tafiditra hook")
    this.handleEvent("SpinTest", ({}) =>
      this.spin_icon()
    )
    this.handleEvent("SpinComment", ({}) =>
      this.spin_comment_icon()
    )
 },
    spin_icon(){
      var spins = document.querySelectorAll('.notif__load');
      // console.log(spin);
      // spins.classList.add('rotate__icon');
      // console.log(spin);
      // window.setTimeout(function(){spins.classList.remove('rotate__icon');}, 500);
      // console.log('notif')
      spins.forEach(item => {
        item.classList.add('new__rotate__icon');
      });

      spins.forEach(item => {
        window.setTimeout(function(){item.classList.remove('new__rotate__icon');}, 500);
      });

    },
    spin_comment_icon(){
      // console.log('comment')
      var clock_comment = document.getElementById('clock_comment');
      // console.log(clock_comment);
      clock_comment.classList.add('rotate__icon');
      // console.log(clock_comment);
      window.setTimeout(function(){clock_comment.classList.remove('rotate__icon');}, 500);
      // console.log(clock_comment);
    }

};


//hook end
// document.querySelector('#messageBody').scrollTop = messageBody.scrollHeight - messageBody.clientHeight

//
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

const menuBtn = document.querySelector('.menu-btn');
let menuOpen = false;
menuBtn.addEventListener('click', () => {
  if(!menuOpen) {
    menuBtn.classList.add('open');
    menuOpen = true;
  } else {
    menuBtn.classList.remove('open');
    menuOpen = false;
  }
});

// var alerts = document.querySelectorAll(".alert");
// console.log(alerts);
//
// alerts.forEach(item => {
//   item.style.opacity = 1
//   item.onload = window.setTimeout(function(){item.style.opacity = 0;}, 2000);
// });


// let alerts = document.querySelectorAll(".alert__test");
// for (var index = 0 ; index < alerts.length; index++) {
//         alerts[index].style.height = "50px";
//     }



// let navToggleProj = document.querySelector(".nav__toggle__proj");
// let navWrapperProj = document.querySelector(".nav__wrapper__project");
// navToggleProj.addEventListener("click", function () {
//   if (navWrapperProj.classList.contains("active")) {
//     this.setAttribute("aria-expanded", "false");
//     this.setAttribute("aria-label", "menu");
//     navWrapperProj.classList.remove("active");
//   } else {
//     navWrapperProj.classList.add("active");
//     this.setAttribute("aria-label", "close menu");
//     this.setAttribute("aria-expanded", "true");
//   }
// });

// var body = document.body;
// body.onload = function(){body.style.visibility = "visible";};

var alerts = document.querySelectorAll(".alert");


//     console.log(alerts);

    alerts.forEach(item => {
      item.style.opacity = 1
      item.onload = window.setTimeout(function(){item.style.opacity = 0;}, 2000);
    });

  // var loadNotifs = document.querySelectorAll(".notif__load");
  //     loadNotifs.forEach(item => {
  //       console.log(item);
  //       item.addEventListener("click", function () {
  //           item.classList.add("rotate__icon");
  //       });
  // });


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
//Working liveSocket
// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

let liveSocket = new LiveSocket("/live", Socket, {
  params: {
    _csrf_token: csrfToken
  },
  hooks: Hooks
  // dom: {
  //   onBeforeElUpdated(from, to){
  //     if(from.__x){ window.Alpine.clone(from.__x, to) }
  //   }
  // }
});



window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

   // "webpack": "^5.39.1",
    // "webpack-cli": "^4.7.2"

liveSocket.connect()

window.liveSocket = liveSocket
