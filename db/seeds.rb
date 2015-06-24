class Seed

  def languages
    ["Ruby", "JavaScript", "VisualBasic", "Python", "Java"].each do |language|
      Language.create(name: language)
    end
  end

  def users
    50.times do |i|
    user = User.create(nickname: "funny name #{i}",
                uid: "100#{i}",
                image_url: "https://avatars.githubusercontent.com/u/7582765?v=3",
                description: "This is my description.")
    user.languages << Language.find(rand(1..3))
    user.languages << Language.find(rand(4..5))
    user.save
    end
  end
end

run = Seed.new
run.languages
run.users
