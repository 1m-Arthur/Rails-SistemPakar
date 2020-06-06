class Disease < ApplicationRecord
    has_many :kesimpulans, class_name: "kesimpulan", foreign_key: "code_penyakit"
end
