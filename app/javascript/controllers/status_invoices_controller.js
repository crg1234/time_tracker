import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status-invoices"
export default class extends Controller {
  static targets = ["colorButton"]
  static values = {
    invoiceSent: Boolean,
    status: Boolean,
    invoiceId: Number,
  }

  connect() {
    console.log("HELLO FROM STATUS INVOICES CONTROLLER")
    console.log(this.colorButtonTarget)
    console.log(this.invoiceSentValue)
    console.log(this.statusValue)
    console.log(this.invoiceId)
  }


  // create a fetch request to update invoice_sent to true while clicking on Create PDF Button
  // call method update_invoice_sent from invoices controller

  // create a fetch request to update status to true while complete
  // add a sumbit button inside invoice showpage to change invoice.status into true
}
