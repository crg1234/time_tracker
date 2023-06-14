import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stop-watch"
export default class extends Controller {
  static targets = [
    'timer',
    'toggle',
    'reset',
    'lap',
    'lapReport'
  ];


  connect() {
    let laptime, lapcount = 0, firstClickOnStart = true;
    let startTime, endTime;
    let lapClick = [];
  }

  timeFormatter(timeInMilliSeconds) {
    let time = new Date(timeInMilliSeconds);
    let minutes = time.getMinutes().toString();
    let seconds = time.getSeconds().toString();
    let milliseconds = time.getMilliseconds().toString();

    if (minutes.length < 2) {
      minutes = "0" + minutes;
    }
    if (seconds.length < 2) {
      seconds = "0" + seconds;
    }
    while (milliseconds.length < 3) {
      milliseconds = "0" + milliseconds;
    }

    return minutes + " : " + seconds + ". " + milliseconds;
  }

  stopWatch(ele) {
    let currentTime = 0;
    let interval;
    let offset;

    function update() {
      if (this.isOn) {
        currentTime += delta();
      }
      let formattedTime = timeFormatter(currentTime);
      ele.textContent = formattedTime;
      laptime = formattedTime;
    }

    function delta() {
      const now = Date.now();
      const timePassed = now - offset;
      offset = now;
      return timePassed;
    }

    this.isOn = false;
    this.start = function () {
      if (!this.isOn) {
        interval = setInterval(update.bind(this), 10);
        offset = Date.now();
        this.isOn = true;
      }
    }

    this.stop = function () {
      if (this.isOn) {
        clearInterval(interval);
        interval = null;
        this.isOn = false;
      }
    }

    this.reset = function () {
      if (!this.isOn) {
        currentTime = 0;
        update();
        lapReport.innerText = "";
        laptime = null;
        lapcount = 0;
        firstClickOnStart = true;
        startTime = null;
        endTime = null;
        lapClick = [];
      }
    }

  }

  toggle() {
    const watch = new stopWatch(timer);
    if (watch.isOn) {
      watch.stop();
      resetBtn.style.display = 'inline-block';
      lapBtn.style.display = 'none';
      toggleBtn.textContent = 'START';
    } else {
      if (firstClickOnStart) {
        startTime = timeFormatter(Date.now());
        firstClickOnStart = false;
      }
      watch.start();
      resetBtn.style.display = 'none';
      lapBtn.style.display = 'inline-block';
      toggleBtn.textContent = 'STOP';
    }
  };

  // resetBtn.addEventListener('click', function() {
  //   endTime = timeFormatter(Date.now());
  //   records.create({ start_time: startTime, end_time: endTime })
  //     .then(newRecord => {
  //       console.log(newRecord);
  //       if (lapClick.length > 0) {
  //         for (let elem of lapClick) {
  //           laps.create({ lap_time: elem, record_id: newRecord.id })
  //             .then(result => {
  //               console.log(result);
  //             })
  //         }
  //       }
  //     })
  //   setTimeout(function () {
  //     watch.reset();
  //   }, 100);
  //   resetBtn.style.display = 'none';
  //   lapBtn.style.display = 'none';
  // });

  // lapBtn.addEventListener('click', function() {
  //     if (watch.isOn) {
  //       let tempLap = timeFormatter(Date.now());
  //       lapClick.push(tempLap);
  //       lapcount++;
  //       if (lapcount < 10) { lapcount = '0' + lapcount };
  //       const newLapTime = document.createElement('li');
  //       newLapTime.className = 'list-group-item';
  //       const lapTimeTitle = `<strong>Lap ${lapcount}</strong> - `;
  //       newLapTime.innerHTML = `${lapTimeTitle} ${laptime}`;
  //       lapReport.appendChild(newLapTime);
  //     }
  //   });

}
