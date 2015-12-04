require "spec_helper"

feature "user views dreams" do
  scenario "sees dreams" do
    db_connection do |conn|
      sql_query = "INSERT INTO dreams (description) VALUES ($1)"
      data = ["I got promoted to the be the Patrios QB and won the superbowl"]
      conn.exec_params(sql_query, data)
    end

    visit "/dreams"
    expect(page).to have_content("I got promoted to the be the Patrios QB and won the superbowl")
  end
end
