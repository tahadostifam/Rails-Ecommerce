require "application_system_test_case"

class AccountDetailsTest < ApplicationSystemTestCase
  setup do
    @account_detail = account_details(:one)
  end

  test "visiting the index" do
    visit account_details_url
    assert_selector "h1", text: "Account details"
  end

  test "should create account detail" do
    visit account_details_url
    click_on "New account detail"

    fill_in "Address1", with: @account_detail.address1
    fill_in "Address2", with: @account_detail.address2
    fill_in "Postal code", with: @account_detail.postal_code
    click_on "Create Account detail"

    assert_text "Account detail was successfully created"
    click_on "Back"
  end

  test "should update Account detail" do
    visit account_detail_url(@account_detail)
    click_on "Edit this account detail", match: :first

    fill_in "Address1", with: @account_detail.address1
    fill_in "Address2", with: @account_detail.address2
    fill_in "Postal code", with: @account_detail.postal_code
    click_on "Update Account detail"

    assert_text "Account detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Account detail" do
    visit account_detail_url(@account_detail)
    click_on "Destroy this account detail", match: :first

    assert_text "Account detail was successfully destroyed"
  end
end
