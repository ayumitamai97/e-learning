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
