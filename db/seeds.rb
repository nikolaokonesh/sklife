# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create( email: "nikolaokonesh@gmail.com",
  first_name: "Nikolay",
  last_name: "Okoneshnikov",
  admin: true,
  password: "825641470",
  password_confirmation: "825641470")

(1..10).each do |i|
  Article::Category.create([
    {
      title: "Категори под номером #{i}",
      body: "Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}.",
      user_id: 1
    }
  ])
end

(1..40).each do |i|
  Article::Post.create([
    {
      title: "Пост под номером #{i}",
      body: "Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}.",
      user_id: 1,
      posttable_id: 1,
      posttable_type: "Article::Category"
    }
  ])
end

(41..80).each do |i|
  Article::Post.create([
    {
      title: "Пост под номером #{i}",
      body: "Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}, Содержание статьи под номером #{i},
            Содержание статьи под номером #{i},
            Содержание статьи под номером #{i}.",
      user_id: 1,
      posttable_id: 2,
      posttable_type: "Article::Category"
    }
  ])
end

# (41..150).each do |i|
#   User.create([
#     {
#       email: "nname_#{i}@gmail.ru",
#       first_name: "noname",
#       last_name: "noname",
#       password: "passport",
#       password_confirmation: "passport"
#     }
#   ])
# end
