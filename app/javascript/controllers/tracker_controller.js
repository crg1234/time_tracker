import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracker"
export default class extends Controller {
  static targets = ["time", "button", "billing", "billingButton"]
  static values = {
    taskId: Number,
    timeLog: Number,
    billingRate: Number,
    amountToBill: Number,
    authenticityToken: String
  }

  connect() {
    this.running = false;
    this.timeTarget.innerText = this.timeFormatter(this.timeLogValue)
    this.billingTarget.innerText = `Amount to Bill: €${parseFloat(this.amountToBillValue / 100).toFixed(2)}`
    this.billingButtonTarget.innerText = `${parseFloat(this.amountToBillValue / 100).toFixed(2)}`
    // console.log(this.billingRateValue);
    // console.log(this.timeTarget);
    // console.log(this.taskIdValue);
    // console.log(this.timeLogValue);
    // console.log(this.billingButtonTarget)
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
    this.updateBilling()

    const formData = new FormData()
    formData.append("task[time_log]", this.timeLogValue)
    formData.append("task[amount_to_bill]", this.amountToBillValue)
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

  updateBilling() {
    console.log(this.billingRateValue)
    this.amountToBillValue = (this.billingRateValue * (this.timeLogValue / 1000)) // to convert milliseconds to seconds
    this.billingTarget.innerText = `Amount to Bill: €${this.amountToBillValue / 100}`
    this.billingButtonTarget.innerText = `${parseFloat(this.amountToBillValue / 100).toFixed(2)}`
    // parseFloat(float_num.toFixed(2))
  }

  timer = () => {
    this.timeLogValue += 1000
    this.timeTarget.innerText = this.timeFormatter(this.timeLogValue)
    this.updateBilling()
  }

  // timeFormatter(ms) {
  //   const min = Math.floor((ms / 1000 / 60) << 0);
  //   const sec = Math.floor((ms / 1000) % 60);

  //   return `${min} : ${sec}`

  // }

  timeFormatter(ms) {
    let seconds = Math.floor((ms / 1000) % 60);
    let minutes = Math.floor((ms / (1000 * 60)) % 60);
    let hours = Math.floor((ms / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;

    return hours + ":" + minutes + ":" + seconds
  }

}
