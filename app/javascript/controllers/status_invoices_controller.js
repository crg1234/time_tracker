import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status-invoices"
export default class extends Controller {
  static targets = ["colorButton", "downloadInvoiceButton"]
  static values = {
    invoiceSent: Boolean,
    status: Boolean,
    invoiceId: Number,
    projectId: Number,
  }

  connect() {
    console.log("HELLO FROM STATUS INVOICES CONTROLLER")
    console.log(this.colorButtonTarget)
    console.log(this.downloadInvoiceButtonTarget)
    console.log(this.invoiceSentValue)
    console.log(this.statusValue)
    console.log(this.invoiceIdValue)

    this.authenticityTokenValue = document.getElementsByName("csrf-token")[0].content;
  }

  // create a fetch request to update invoice_sent to true while clicking on Create PDF Button
  // call method update_invoice_sent from invoices controller

  clickInvoiceDownload() {
    console.log("the button was clicked")
    console.log(this.downloadInvoiceButtonTarget)

    this.invoiceSent()
  }

  invoiceSent() {
    this.invoiceSentValue = true
    console.log("the button was clicked and we are changing the invoice sent status")
    console.log(`identifier ${this.invoiceIdValue}`)
    console.log(this.invoiceSentValue)

    const formData = new FormData()
    formData.append("invoice[invoice_sent]", this.invoiceSentValue)
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


  // create a fetch request to update status to true while complete
  // add a sumbit button inside invoice showpage to change invoice.status into true
}
