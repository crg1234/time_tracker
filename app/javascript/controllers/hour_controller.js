import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hour"
export default class extends Controller {
  static targets = ["hour1", "hour2", "min1", "min2", "sec1", "sec2"]

  connect() {
    setInterval(() => {
      const currentTime = new Date()
      const hours = currentTime.getHours().toString().padStart(2, '0')
      // if(hours.length == 1) { hours = ["0", hours]
      // }
      const mins = currentTime.getMinutes().toString().padStart(2, '0')
      const secs = currentTime.getSeconds().toString().padStart(2, '0')

      console.log(currentTime)

      this.hour1Target.innerText = hours[0]
      this.hour2Target.innerText = hours[1]
      this.min1Target.innerText = mins[0]
      this.min2Target.innerText = mins[1]
      this.sec1Target.innerText = secs[0]
      this.sec2Target.innerText = secs[1]
    }, 1000);

  }

}
