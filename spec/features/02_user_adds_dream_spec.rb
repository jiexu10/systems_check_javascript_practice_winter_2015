require "spec_helper"

feature "user add dream", js: true do

  scenario "successfully add dream" do
    visit "/dreams"
    fill_in "Description", with: "Bill Gates asked me to take over his company"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to have_content "Bill Gates asked me to take over his company"
    end
  end

  scenario "submit form without description" do
    visit "/dreams"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to_not have_css("li")
    end
  end
end
