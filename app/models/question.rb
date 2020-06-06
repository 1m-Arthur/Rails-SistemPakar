class Question < ApplicationRecord
    has_many :kesimpulans, class_name: "kesimpulan", foreign_key: "stage"
end
