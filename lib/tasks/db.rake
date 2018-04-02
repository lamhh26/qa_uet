namespace :db do
  desc "Seeding data"
  task remake_data: :environment do
    return puts "Do not running in 'Production' task" if Rails.env.production?
    %w(db:drop db:create db:migrate).each do |task|
      Rake::Task[task].invoke
    end

    puts "Create users"
    300.times.each do
      User.create email: FFaker::Internet.email, name: FFaker::Name.name, about_me: FFaker::Lorem.sentence,
        birth_day: FFaker::Time.date(year_range: 20, year_latest: 20), created_at: FFaker::Time.date, password: "123456"
    end

    puts "Create tags"
    tags_name = FFaker::Skill.tech_skills 100
    tags_name.each{|tag_name| Tag.create name: tag_name}
    tags = Tag.all

    users = User.all
    puts "Create posts"
    users.sample(200).each do |user|
      rand(1..20).times.each do |_|
        user.posts.create post_type: :question, title: FFaker::Lorem.sentence, created_at: FFaker::Time.date,
          body: FFaker::Lorem.paragraphs.join(". "), tags: tags.sample(rand(1..5))
      end
    end

    puts "Create answers"
    post_question_size = Post.question.count
    post_question_size_range = rand((post_question_size - 100)..post_question_size)
    Post.question.sample(post_question_size_range).each do |post|
      users.sample(rand(1..20)).each do |user|
        next if user == post.owner_user
        post.answers.create post_type: :answer, body: FFaker::Lorem.paragraphs.join(". "), owner_user: user
      end
    end

    puts "Create comments"
    Post.all.each do |post|
      post.comments.create user: users.sample, text: FFaker::Lorem.sentence
    end

    puts "Create votes"
    post_size = Post.count
    post_size_range = rand((post_size - 200)..post_size)
    Post.all.sample(post_size_range).each do |post|
      users.sample(rand(5..100)).each do |user|
        next if user == post.owner_user
        post.votes.create vote_type: %i(up_mod down_mod).sample, user: user
      end
    end
  end
end
