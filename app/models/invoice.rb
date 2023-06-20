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


  def total_billing_amount
    billing_amount = 0
    self.project.tasks.each do |task|
      if task.amount_to_bill.nil?
        billing_amount
      else
        billing_amount += task.amount_to_bill
      end
    end
    return billing_amount
  end

  def total_time_amount
    total_time_on_invoice = 0
    self.project.tasks.each do |task|
      if task.time_log.nil?
        total_time_on_invoice
      else
        total_time_on_invoice += task.time_log
      end
    end
    return total_time_on_invoice
  end

end
