import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracker"
export default class extends Controller {
  static targets = ["time", "button"]
  static values = {
    taskId: Number,
    timeLog: Number,
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
