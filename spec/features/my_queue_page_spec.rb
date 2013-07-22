require 'spec_helper'

feature "User interacts with the queue" do
  background do
    action = Fabricate(:genre)
    @video1 = Fabricate(:video, title: "monk")
    @video2 = Fabricate(:video, title: "South Park")
    @video3 = Fabricate(:video, title: "Futurama")
    @video1.genres << action
    @video2.genres << action
    @video3.genres << action
  end

  scenario "user adds and reorders videos on the queue" do

    sign_in

    find("a[href='/videos/#{@video1.id}']").click
    expect(page).to have_content(@video1.title)
    click_link "+ My Queue"
    expect(page).to have_content(@video1.title)

    visit video_path(@video1)
    expect(page).to_not have_content "+ My Queue"

    add_video_to_queue(@video2)
    add_video_to_queue(@video3)

    set_video_position(@video1, 3)
    set_video_position(@video2, 1)
    set_video_position(@video3, 2)

    click_button "Update Instant Queue"

    expect_video_position(@video2, 1)
    expect_video_position(@video3, 2)
    expect_video_position(@video1, 3)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

end