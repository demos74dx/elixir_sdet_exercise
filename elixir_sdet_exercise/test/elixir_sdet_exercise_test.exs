defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  import Screenshot
  import Facebook.LoginPage

  # Start hound session and destroy when tests are run
  hound_session()

  test "goes to facebook Sign Up Modal" do
    visit_login_page()
    assert_sof page_title() =~ "Facebook"
    open_sign_up_modal()
    assert_sof sign_up_button_is_present?() #success if the signup button is present
  end

  test "missing First Name Field fails fast" do
    visit_login_page()
    open_sign_up_modal()
    refute_sof invalid_input_is_present?()
    fill_last_name("TestLast")
    assert_sof invalid_input_is_present?()
  end

  test "missing Last Name Field" do
    visit_login_page()
    open_sign_up_modal()
    refute_sof invalid_input_is_present?()
    fill_first_name("TestFirst")
    fill_email("test@gmail.com")
    fill_email_confirm("test@gmail.com")
    fill_password("TestPassword")
    select_birth_month("Mar")
    select_birth_day("31")
    select_birth_year("1990")
    click_female_radio()
    click_sign_up_button()
    assert_sof invalid_input_is_present?()
  end

  test "missing Email Field" do
    visit_login_page()
    open_sign_up_modal()
    refute_sof invalid_input_is_present?()
    fill_first_name("TestFirst")
    fill_last_name("TestLast")
    fill_password("TestPassword")
    select_birth_month("Mar")
    select_birth_day("31")
    select_birth_year("1990")
    click_female_radio()
    click_sign_up_button()
    refute_sof email_confirm_is_visible?()
    assert_sof invalid_input_is_present?()
  end

  test "check Email Confirmation Field visibility" do
    visit_login_page()
    open_sign_up_modal()
    fill_first_name("TestFirst")
    fill_last_name("TestLast")
    refute_sof email_confirm_is_visible?()
    fill_email("test")
    #email confirmation doesn't appear until a valid email is present
    refute_sof email_confirm_is_visible?()
    fill_email("test@gmail.com")
    assert_sof email_confirm_is_visible?()
    fill_email_confirm("testBAD@gmail.com")
    fill_password("TEst!@#412312") #refresh ajax
    assert_sof invalid_input_is_present?()
    fill_email_confirm("test@gmail.com")
    click_female_radio() #refresh ajax
    refute_sof invalid_input_is_present?()
  end

  test "missing Birthday info" do
    visit_login_page()
    open_sign_up_modal()
    refute_sof invalid_input_is_present?()
    fill_first_name("TestFirst")
    fill_last_name("TestLast")
    fill_email("test@gmail.com")
    fill_email_confirm("test@gmail.com")
    fill_password("TestPassword")
    click_female_radio()
    click_sign_up_button()
    fill_first_name("TestFirst1") #refresh ajax
    assert_sof invalid_input_is_present?()
  end

  test "missing Gender Radio" do
    visit_login_page()
    open_sign_up_modal()
    refute_sof invalid_input_is_present?()
    fill_first_name("TestFirst")
    fill_last_name("TestLast")
    fill_email("test@gmail.com")
    fill_email_confirm("test@gmail.com")
    fill_password("TestPassword")
    select_birth_month("Mar")
    select_birth_day("31")
    select_birth_year("1990")
    click_sign_up_button()
    fill_first_name("TestFirst1") #refresh ajax
    assert_sof invalid_input_is_present?()
  end

end
