class Seed
  def languages
    ["Ruby", "JavaScript", "VisualBasic", "Python", "Java"].each do |language|
      Language.create(name: language)
    end
  end
end

Seed.new.languages
