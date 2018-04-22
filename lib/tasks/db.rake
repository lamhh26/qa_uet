namespace :db do
  desc "Seeding data"
  task remake_data: :environment do
    return puts "Do not running in 'Production' task" if Rails.env.production?
    %w(db:drop db:create db:migrate).each do |task|
      Rake::Task[task].invoke
    end

    puts "Create course categories"
    CourseCategory.create! name: "Hoc ky I", date_from: "1-8-2016", date_to: "31-1-2017"
    CourseCategory.create! name: "Hoc ky II", date_from: "1-2-2017", date_to: "30-6-2017"
    CourseCategory.create! name: "Hoc ky I", date_from: "1-8-2017", date_to: "31-1-2018"
    CourseCategory.create! name: "Hoc ky II", date_from: "1-2-2018", date_to: "30-6-2018"

    puts "Create courses"
    CourseCategory.all.each do |category|
      10.times.each do
        category.courses.create! name: FFaker::Education.unique.major, code: FFaker::AddressUK.unique.postcode
      end
    end

    puts "Create users"
    courses = Course.all
    200.times.each do
      User.create! email: FFaker::Internet.email, name: FFaker::Name.name, about_me: FFaker::Lorem.sentence,
        birth_day: FFaker::Time.date(year_range: 20, year_latest: 20).in_time_zone, created_at: FFaker::Time.date(year_latest: 0.5),
        password: "123456"
    end

    puts "Create user courses"
    users = User.all
    users.each do |user|
      courses.ids.sample(rand(4..10)).each do |id|
        user.user_courses.create! course_id: id
      end
    end

    puts "Update lecturers"
    courses.each do |course|
      next if course.users.lecturers.exists?
      course.users.sample.update_attributes! lecturer: true
    end

    puts "Create tags"
    tags_name = FFaker::Skill.tech_skills 100
    tags_name.each{|tag_name| Tag.create! name: tag_name}
    tags = Tag.all

    users = User.all
    puts "Create posts"
    users.sample(150).each do |user|
      rand(1..10).times.each do |_|
        course = user.courses.sample
        course_category = course.course_category
        date_to = course_category.date_to > Time.current ? Time.current : course_category.date_to
        user.posts.create! post_type: :question, title: FFaker::Lorem.sentence,
          body: FFaker::Lorem.paragraphs.join(". "), tags: tags.sample(rand(1..5)), course: course,
          created_at: FFaker::Time.between(course_category.date_from, date_to).in_time_zone
      end
    end

    puts "Create answers"
    Post.question.sample(150).each do |post|
      post.course.users.sample(rand(1..15)).each do |user|
        next if user == post.owner_user
        course_category = post.course.course_category
        date_to = course_category.date_to > Time.current ? Time.current : course_category.date_to
        post.answers.create! post_type: :answer, body: FFaker::Lorem.paragraphs.join(". "), owner_user: user,
          created_at: FFaker::Time.between(post.created_at, date_to).in_time_zone
      end
    end

    puts "Create comments"
    Post.all.each do |post|
      course_category = post.course.course_category
      date_to = course_category.date_to > Time.current ? Time.current : course_category.date_to
      post.comments.create! user: users.sample, text: FFaker::Lorem.sentence,
        created_at: FFaker::Time.between(post.created_at, date_to).in_time_zone
    end

    puts "Create votes"
    courses.each do |course|
      Post.of_courses(course).sample(10).each do |post|
        course.users.sample(rand(5..10)).each do |user|
          next if user == post.owner_user
          course_category = post.course.course_category
          date_to = course_category.date_to > Time.current ? Time.current : course_category.date_to
          post.votes.create! vote_type: %i(up_mod down_mod).sample, user: user,
            created_at: FFaker::Time.between(post.created_at, date_to).in_time_zone
        end
      end
    end
  end
end
