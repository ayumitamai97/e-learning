User.create!(name: "Taro Yamada",
            email: "taro@example.com",
            password: "super_strong_password",
            password_confirmation: "super_strong_password",
            admin: true)

100.times do |time|
  User.create!(name: "User" + time.to_s,
              email: "email" + time.to_s + "@example.com",
              password: "password",
              password_confirmation: "password",
              admin: false)
end

100.times do
  Category.find(6).words.create(
    question: "cat", option_1: "いぬ", option_2: "ねこ", option_3: "やぎ", option_4: "ひつじ", answer: "ねこ")
end

100.times do |time|
  Category.create(title: "title" + time.to_s, description: "desc" + time.to_s)
end
