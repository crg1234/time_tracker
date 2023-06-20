class Invoice < ApplicationRecord
  belongs_to :project

  def status_check
    if self.status == false && self.invoice_sent == false
      "PENDING"
      # <td><button class="button btn-status pastel-red" data-status-invoices-target="colorButton">Pending</button></td>
    elsif self.invoice_sent == true && self.status == false
      "SENT"
      # <td><button class="button btn-status pastel-orange" data-status-invoices-target="colorButton">Sent</button></td>
    elsif self.status == true
      "PAID"
      # <td><button class="button btn-status pastel-green" data-status-invoices-target="colorButton">Paid</button></td>
    end

  end
end
