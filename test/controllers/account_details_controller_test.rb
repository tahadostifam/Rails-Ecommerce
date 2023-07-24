require "test_helper"

class AccountDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account_detail = account_details(:one)
  end

  test "should get index" do
    get account_details_url
    assert_response :success
  end

  test "should get new" do
    get new_account_detail_url
    assert_response :success
  end

  test "should create account_detail" do
    assert_difference("AccountDetail.count") do
      post account_details_url, params: { account_detail: { address1: @account_detail.address1, address2: @account_detail.address2, postal_code: @account_detail.postal_code } }
    end

    assert_redirected_to account_detail_url(AccountDetail.last)
  end

  test "should show account_detail" do
    get account_detail_url(@account_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_detail_url(@account_detail)
    assert_response :success
  end

  test "should update account_detail" do
    patch account_detail_url(@account_detail), params: { account_detail: { address1: @account_detail.address1, address2: @account_detail.address2, postal_code: @account_detail.postal_code } }
    assert_redirected_to account_detail_url(@account_detail)
  end

  test "should destroy account_detail" do
    assert_difference("AccountDetail.count", -1) do
      delete account_detail_url(@account_detail)
    end

    assert_redirected_to account_details_url
  end
end
