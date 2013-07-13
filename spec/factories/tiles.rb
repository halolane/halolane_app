# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tile do
    template_id 1
    datarow 1
    datacol 1
    datasizex 1
    datasizey 1
    tile_num 1
  end
end
