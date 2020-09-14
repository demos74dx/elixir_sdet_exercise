defmodule Facebook.LoginPage do
    @moduledoc "Provides page elements for the Login Page"

    use PageObject

    visitable :visit, "http://www.facebook.com"

    clickable :click_create_new_account_button, "#u_0_2"

    fillable :fill_first_name, "input[name='firstname']"
    fillable :fill_last_name, "input[name='lastname']"
    fillable :fill_email, "input[name='reg_email__']"
    fillable :fill_email_confirm, "input[name='reg_email_confirmation__']"
    fillable :fill_password, "input[name='reg_passwd__']"
    selectable :select_birth_month, "select[name='birthday_month']"
    selectable :select_birth_day, "select[name='birthday_day']"
    selectable :select_birth_year, "select[name='birthday_year']"
    clickable :click_female_radio, "input[name='sex'][value='1']"
    clickable :click_male_radio, "input[name='sex'][value='2']"
    clickable :click_custom_radio, "input[name='sex'][value='3']"

    is_present? :sign_up_button_is_present?, "button[name='websubmit']"
    clickable :click_sign_up_button, "button[name='websubmit']"

  def visit_login_page do
    visit()
    IO.inspect page_title()
  end

  def open_sign_up_modal do
    click_create_new_account_button()
    :timer.sleep(500) #wait until the modal has fully loaded
  end

    def invalid_input_is_present? do
      try do
          element_displayed?({:class, "_5dbc"}) # any error icons?
          or element_displayed?({:css, "input[aria-describedby]"}) # or input error text?
          or element_displayed?({:css, "div[aria-describedby]"}) # or div error text?
          or element_displayed?({:css, "span[aria-describedby]"}) # or span error text?
      rescue
        Hound.NoSuchElementError -> false # NSEE means theres no errors on the page.
      end
  end

  def email_confirm_is_visible? do
      element_displayed?({:css, "input[name='reg_email_confirmation__']"})
  end

end