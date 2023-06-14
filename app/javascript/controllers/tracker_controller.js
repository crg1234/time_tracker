import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracker"
export default class extends Controller {
  static targets = ["complete", "time", "form"]
  static values = { task: Number }
  connect() {
    console.log(this.timeTarget);
    console.log(this.completeTarget);
    console.log(this.formTarget);
  }

  save(event) {
    console.log(event)
    console.log(this.taskValue)
    console.log(this.timeTarget.innerHTML)


  }

  update(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
      })
  }


// @task
// => # < Task id: 6, title: "Update database", description: "Just do it right", billing_rate: 1.5, start_time: "2000-01-01 07:40:31.000000000 +0000", end_time: "2000-01-01 19:17:10.000000000 +0000", project_id: 17, created_at: "2023-06-13 13:01:27.593274000 +0000", updated_at: "2023-06-13 13:01:27.593274000 +0000" >
