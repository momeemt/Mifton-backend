require "application_system_test_case"

class ConvenienceLinksTest < ApplicationSystemTestCase
  setup do
    @convenience_link = convenience_links(:one)
  end

  test "visiting the index" do
    visit convenience_links_url
    assert_selector "h1", text: "Convenience Links"
  end

  test "creating a Convenience link" do
    visit convenience_links_url
    click_on "New Convenience Link"

    fill_in "Description", with: @convenience_link.description
    fill_in "Is public", with: @convenience_link.is_public
    fill_in "Link", with: @convenience_link.link
    fill_in "Name", with: @convenience_link.name
    click_on "Create Convenience link"

    assert_text "Convenience link was successfully created"
    click_on "Back"
  end

  test "updating a Convenience link" do
    visit convenience_links_url
    click_on "Edit", match: :first

    fill_in "Description", with: @convenience_link.description
    fill_in "Is public", with: @convenience_link.is_public
    fill_in "Link", with: @convenience_link.link
    fill_in "Name", with: @convenience_link.name
    click_on "Update Convenience link"

    assert_text "Convenience link was successfully updated"
    click_on "Back"
  end

  test "destroying a Convenience link" do
    visit convenience_links_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Convenience link was successfully destroyed"
  end
end
