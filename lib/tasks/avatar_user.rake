namespace :user do
  desc "Update avatar"
  task update_avatar: :environment do
    User.all.each do |user|
      user.update_attributes remote_avatar_url: FFaker::Avatar.image.gsub("http://", "https://")
    end
  end
end
