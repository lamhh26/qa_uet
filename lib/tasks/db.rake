namespace :db do
  desc "Seeding data"
  task remake_data: :environment do
    return puts "Do not running in 'Production' task" if Rails.env.production?
    %w(db:drop db:create db:migrate).each do |task|
      Rake::Task[task].invoke
    end

    puts "Create categories"
    10.times.each do
      Category.create name: FFaker::Education.unique.major
    end

    puts "Create users"
    200.times.each do
      User.create email: FFaker::Internet.email, name: FFaker::Name.name, about_me: FFaker::Lorem.sentence,
        birth_day: FFaker::Time.date(year_range: 20, year_latest: 20), created_at: FFaker::Time.date(year_latest: 0.5),
        password: "123456"
    end

    puts "Update consultant"
    consultants = User.all.sample(10).each do |user|
      user.update_attributes consultant: true
    end
    categories = Category.all
    consultants.each do |consultant|
      consultant.categories = categories.sample(rand(1..5))
    end

    puts "Create tags"
    tags_name = FFaker::Skill.tech_skills 100
    tags_name.each{|tag_name| Tag.create name: tag_name}
    tags = Tag.all

    users = User.all
    puts "Create posts"
    users.sample(150).each do |user|
      rand(1..10).times.each do |_|
        user.posts.create post_type: :question, title: FFaker::Lorem.sentence,
          created_at: FFaker::Time.date(year_latest: 0.5), body: FFaker::Lorem.paragraphs.join(". "),
          tags: tags.sample(rand(1..5)), category: categories.sample
      end
    end

    puts "Create answers"
    Post.question.sample(150).each do |post|
      users.sample(rand(1..15)).each do |user|
        next if user == post.owner_user
        post.answers.create post_type: :answer, body: FFaker::Lorem.paragraphs.join(". "), owner_user: user
      end
    end

    puts "Create comments"
    Post.all.each do |post|
      post.comments.create user: users.sample, text: FFaker::Lorem.sentence
    end

    puts "Create votes"
    Post.all.sample(200).each do |post|
      users.sample(rand(5..50)).each do |user|
        next if user == post.owner_user
        post.votes.create vote_type: %i(up_mod down_mod).sample, user: user
      end
    end
  end
end
