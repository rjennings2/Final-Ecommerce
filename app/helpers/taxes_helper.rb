module TaxesHelper
  TAX_RATES = {
    'Ontario' => { gst: 0.13, pst: 0.00, hst: 0.13 },
    'British Columbia' => { gst: 0.05, pst: 0.07, hst: 0.00 },
    'Alberta' => { gst: 0.05, pst: 0.00, hst: 0.00 },
    'Manitoba' => { gst: 0.05, pst: 0.07, hst: 0.00 },
    'Saskatchewan' => { gst: 0.05, pst: 0.07, hst: 0.00 }
  }

  def calculate_taxes(province, total_price)
    rates = TAX_RATES[province]
    gst = total_price * rates[:gst]
    pst = total_price * rates[:pst]
    hst = total_price * rates[:hst]

    { gst: gst, pst: pst, hst: hst }
  end

  def total_taxes(province, total_price)
    taxes = calculate_taxes(province, total_price)
    taxes[:gst] + taxes[:pst] + taxes[:hst]
  end
end