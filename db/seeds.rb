def language_creation
  %w(Ruby JavaScript CSS HTML Java VisualBasic).each do |language|
    Language.create(name: language)
  end
end

language_creation
