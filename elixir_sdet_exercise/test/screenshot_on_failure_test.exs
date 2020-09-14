# ATTENTION: These tests are designed to fail in order to generate screenshots.
defmodule ScreenshotOnFailureTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  import Screenshot
  import Facebook.LoginPage

  # Start hound session and destroy when tests are run
  hound_session()

  test "assert_sof takes screenshot" do
    visit_login_page()
    assert_sof page_title() =~ "Google"
  end

  test "refute_sof takes screenshot" do
    visit_login_page()
    refute_sof page_title() =~ "Facebook"
  end

end