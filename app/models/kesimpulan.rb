class Kesimpulan < ApplicationRecord
    belongs_to :kesimpulan, class_name: "kesimpulan", foreign_key: "code_penyakit"
    belongs_to :question, class_name: "question", foreign_key: "stage"
end
