import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracker"
export default class extends Controller {
  static targets = ["time", "button"]
  static values = {
    taskId: Number,
    timeLog: Number,
    amountToBill: Number,
    authenticityToken: String
  }

  connect() {
    this.running = false;
    this.timeTarget.innerText = this.timeFormatter(this.timeLogValue)
    // console.log(this.timeTarget);
    // console.log(this.taskIdValue);
    // console.log(this.timeLogValue);
  }

  toggle() {
    if (this.running) {
      this.stop()
    } else {
      this.start()
    }
  }

  start() {
    this.running = true
    this.buttonTarget.innerText = "STOP"
    this.interval = setInterval(this.timer, 1000) // in milliseconds
  }

  stop() {
    this.running = false
    this.buttonTarget.innerText = "START"
    clearInterval(this.interval)

    const formData = new FormData()
    formData.append("task[time_log]", this.timeLogValue)
    formData.append("authenticity_token", this.authenticityTokenValue)
    formData.append("task[amount_to_bill]", this.amountToBillValue)

    fetch(`/tasks/${this.taskIdValue}`, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: formData
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
      })
  }

  timer = () => {
    this.timeLogValue += 1000
    this.timeTarget.innerText = this.timeFormatter(this.timeLogValue)

  }

  timeFormatter(ms) {
    const min = Math.floor((ms / 1000 / 60) << 0);
    const sec = Math.floor((ms / 1000) % 60);

    return `${min} : ${sec}`

    // const hours = Math.floor(ms / 3_600_000);
    // const minutes = Math.floor((ms - (hours * 3600000)) / 60);
    // const seconds = ms - (hours * 3600000) - (minutes * 60);

    // if (hours < 10) { hours = "0" + hours; }
    // if (minutes < 10) { minutes = "0" + minutes; }
    // if (seconds < 10) { seconds = "0" + seconds; }
    // return `${hours} : ${minutes} : ${seconds}`;
  }



  // save(event) {
  //   console.log(event)
  //   console.log(this.taskValue)
  //   console.log(this.timeTarget.innerHTML)

  // }

  // update(event) {
  //   event.preventDefault()
  //   const url = this.formTarget.action
  //   fetch(url, {
  //     method: "PATCH",
  //     headers: { "Accept": "text/plain" },
  //     body: new FormData(this.formTarget)
  //   })
  //     .then(response => response.text())
  //     .then((data) => {
  //       console.log(data)
  //     })
  // }
}
