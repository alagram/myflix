require 'spec_helper'

describe "Create payment on successful charge" do

  let(:event_data) do
    event_data = {
  "id" => "evt_2Txeh8Qd8Kl2vl",
  "created" => 1377899227,
  "livemode" => false,
  "type" => "charge.succeeded",
  "data" => {
    "object" => {
      "id" => "ch_2TxeCaxulWL2Pa",
      "object" => "charge",
      "created" => 1377899227,
      "livemode" => false,
      "paid" => true,
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "card" => {
        "id" => "card_2TxelnlidBQpyj",
        "object" => "card",
        "last4" => "4242",
        "type" => "Visa",
        "exp_month" => 8,
        "exp_year" => 2016,
        "fingerprint" => "LQEcKvmcmISI9MHt",
        "customer" => "cus_2TxeeGXVGAg5oC",
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
      "captured" => true,
      "refunds" => [],
      "balance_transaction" => "txn_2TxeYPR6VlcrFy",
      "failure_message" => nil,
      "failure_code" => nil,
      "amount_refunded" => 0,
      "customer" => "cus_2TxeeGXVGAg5oC",
      "invoice" => "in_2TxeNip1521FPM",
      "description" => nil,
      "dispute" => nil
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "iar_2Txeh7gS5DzQlh"
}
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_2TxeeGXVGAg5oC")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_2TxeeGXVGAg5oC")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference_id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_2TxeeGXVGAg5oC")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_2TxeCaxulWL2Pa")
  end
end