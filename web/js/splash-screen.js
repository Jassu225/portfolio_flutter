var showSplashScreen, hideSplashScreen;

(function () {
  function SplashScreen() {
    const containerID = `loader-container-${new Date().getTime()}`;
    this.containerID = containerID;
    this.template = `
    <div id="${containerID}">
      <style>
        #${containerID} {
          width: 100vw;
          height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
        }
        svg#loader {
          width: 60px;
          height: 60px;
        }
      </style>
      <svg id="loader" viewBox="0 0 100 100" fill="none" stroke="#4C7DF6" stroke-linecap="round">
        <style>
          @keyframes rotate {
            0% {
              transform: rotate(0);
            }
  
            100% {
              transform: rotate(360deg);
            }
          }
  
          svg#loader {
            animation: rotate 2s linear infinite;
          }
  
          @keyframes load {
  
            0%,
            100% {
              stroke-dashoffset: 240;
            }
  
            50% {
              stroke-dashoffset: 0;
            }
  
            50.1% {
              stroke-dashoffset: 480;
            }
          }
  
          circle#loader-circle {
            stroke-width: 6px;
            stroke-dasharray: 240;
            stroke-dashoffset: 240;
            animation: load 2s linear infinite;
          }
        </style>
        <circle id="loader-circle" cx="50" cy="50" r="44" />
      </svg>
    </div>
    `;
  }

  SplashScreen.prototype.show = function () {
    const dummy = document.createElement("div");
    dummy.innerHTML = this.template;
    dummy.firstChild.remove();
    document.body.appendChild(dummy.firstChild);
  };

  SplashScreen.prototype.hide = function () {
    const el = document.getElementById(this.containerID);
    if (el) el.remove();
  };

  const splashScreen = new SplashScreen();

  showSplashScreen = function () {
    splashScreen.show();
  };
  hideSplashScreen = function () {
    splashScreen.hide();
  };
})();
