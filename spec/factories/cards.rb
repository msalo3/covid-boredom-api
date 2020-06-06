FactoryBot.define do
  factory :card do
    name { "MyString" }
    info { "MyText" }
    vertical { false }
    sold { false }
    main_image { false }
  end
end
