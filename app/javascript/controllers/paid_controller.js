import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="paid"
export default class extends Controller {
  static targets = ["updateMarkButton"]
  static values = {
    invoiceSent: Boolean,
    status: Boolean,
    invoiceId: Number,
    projectId: Number,
  }

  connect() {
    console.log("HELLO FROM PAID CONTROLLER")
    console.log(this.updateMarkButtonTarget)
    console.log(this.invoiceSentValue)
    console.log(this.statusValue)
    console.log(this.invoiceIdValue)

    this.authenticityTokenValue = document.getElementsByName("csrf-token")[0].content;
  }

  clickMarkButton() {
    console.log("the button was clicked")
    console.log(this.updateMarkButtonTarget)
    this.updateMarkButtonTarget.innerText = "PAID"
    this.updateMarkButtonTarget.classList.remove("btn-outline-secondary")
    this.updateMarkButtonTarget.classList.add("btn-outline-success")

    this.statusValue()


  }

  statusValue() {
    this.statusValue = true
    console.log("the button was clicked and we are changing the invoice status")
    console.log(`identifier ${this.invoiceIdValue}`)
    console.log(this.statusValue)

    const formData = new FormData()
    formData.append("invoice[status]", this.statusValue)
    formData.append("authenticity_token", this.authenticityTokenValue)

    fetch(`/invoices/${this.invoiceIdValue}`, {
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
