import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["projectDate"]

  connect() {
    flatpickr(this.projectDateTarget, {
      // enableTime: true,
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: "today"
      // more options available on the documentation!
    });
  }
}
