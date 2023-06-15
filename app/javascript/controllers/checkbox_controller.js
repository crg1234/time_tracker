import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  static targets = ["checkbox"]
  static values = {
    taskCompleted: Boolean,
    taskId: Number
  }

  connect() {
    // console.log("HELLO")
    console.log(this.checkboxTarget)
    console.log(this.checkboxTarget.checked)
    console.log(this.taskCompletedValue)

    this.authenticityTokenValue = document.getElementsByName("csrf-token")[0].content;
  }

  toggle() {
    console.log(this.checkboxTarget.checked)
    if (this.checkboxTarget.checked) {
      this.completeTask()
    } else {
      this.uncompleteTask()
    }
  }

  completeTask() {
    this.status = true
    this.taskCompletedValue = true
    console.log("the box is checked")
    console.log(`identifier ${this.taskIdValue}`)

    const formData = new FormData()
    formData.append("task[completed]", this.taskCompletedValue)
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

  uncompleteTask() {
    console.log("the box is unchecked")
  }

  uncompleteTask() {
    this.status = false
    this.taskCompletedValue = false

    const formData = new FormData()
    formData.append("task[completed]", this.taskCompletedValue)
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

}
