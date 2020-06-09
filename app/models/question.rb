class Question < ApplicationRecord
    has_many :kesimpulans, class_name: "Kesimpulan"
end
