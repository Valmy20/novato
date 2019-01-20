FactoryBot.define do
  factory :publication do
    title { Faker::Name.name }
    _type { 1 }
    information { Faker::Lorem.paragraph_by_chars([200, 250, 350, 470].sample, false) }
    remunaration { 500 }
    vacancies { 2 }
    publicationable_type {"Employer"}
    publicationable_id { Employer.last.id }
  end
end
