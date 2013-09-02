require 'spec_helper'

describe "Deactivate user on failed charge" do
  let( :event_data) do
  {
    "id" => "evt_2UC2e9XSE8YjGL",
    "created" => 1377952743,
    "livemode" => false,
    "type" => "charge.failed",
    "data" => {
      "object" => {
        "id" => "ch_2UC2jT3CmrvdQI",
        "object" => "charge",
        "created" => 1377952743,
        "livemode" => false,
        "paid" => false,
        "amount" => 999,
        "currency" => "usd",
        "refunded" => false,
        "card" => {
          "id" => "card_2UC0j00CWC4dRZ",
          "object" => "card",
          "last4" => "0341",
          "type" => "Visa",
          "exp_month" => 8,
          "exp_year" => 2018,
          "fingerprint" => "CNyAAUepy4ykYBRE",
          "customer" => "cus_2UASeiEJ7EhHiA",
          "country" => "US",
          "name" => nil,
          "address_line1" => nil,
          "address_line2" => nil,
          "address_city" => nil,
          "address_state" => nil,
          "address_zip" => nil,
          "address_country" => nil,
          "cvc_check" => "pass",
          "address_line1_check" => nil,
          "address_zip_check" => nil
        },
        "captured" => false,
        "refunds" => [],
        "balance_transaction" => nil,
        "failure_message" => "Your card was declined.",
        "failure_code" => "card_declined",
        "amount_refunded" => 0,
        "customer" => "cus_2UASeiEJ7EhHiA",
        "invoice" => nil,
        "description" => "Payment fail.",
        "dispute" => nil
      }
    },
    "object" => "event",
    "pending_webhooks" => 1,
    "request" => "iar_2UC2z6gf4GNBIx"
  }
  end

  it "deactivates a user with the web hook data from strpe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_2UASeiEJ7EhHiA")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end