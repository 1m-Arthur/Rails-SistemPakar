class Disease < ApplicationRecord
    has_many :kesimpulans, class_name: "Kesimpulan"
end
