# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars'}, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
questions = [
    { stage: "G01", nama_gejala: "Perubahan suara serta sulit atau rasa sakit saat menelan serta mengunyah"},
    { stage: "G02", nama_gejala: "Pembengkakan pada wajah dan leher"},
    { stage: "G03", nama_gejala: "Bercak kemerahan atau putih dalam mulut, dan lidah terasa sakit atau mulut nyeri"},
    { stage: "G04", nama_gejala: "Pendarahan pada rongga mulut dan gigi tanggal dengan sendirinya"},
    { stage: "G05", nama_gejala: "Batuk kronis serta telinga terasa sakit dan berdengung"},
    { stage: "G06", nama_gejala: "Timbul benjolan yang muncul di sekitar mata, rahang, leher, atau tenggorokan"},
    { stage: "G07", nama_gejala: "Pembengkakan kelenjar getah bening"},
    { stage: "G08", nama_gejala: "Dada sesak, nyeri, dan berat"},
    { stage: "G09", nama_gejala: "Batuk berdahak disertai bercak darah"},
    { stage: "G10", nama_gejala: "Sakit pada tulang, bisa pada bahu, lengan atau tangan serta perubahan pada bentuk jari, yaitu ujung jari menjadi cembung"},
    { stage: "G11", nama_gejala: "Gatal-gatal atau rasa sakit pada payudara atau ketiak serta perubahan ukuran atau bentuk puting"},
    { stage: "G12", nama_gejala: "Kemunculan benjolan atau pembengkakan yang kemerahan pada ketiak, atau payudara, atau kulit payudara yang menebal serta keluarnya cairan dari puting (biasanya disertai darah)"},
    { stage: "G13", nama_gejala: "Frekuensi buang air kecil semakin sering, tapi jumlah urine yang dikeluarkan hanya sedikit, serta warna urin keruh atau kuning kemerahan"},
    { stage: "G14", nama_gejala: "Kandung kemih terasa tegang, penuh, keras dan nyeri pada perut bagian bawah, serta nyeri atau perih kertika buang air kecil"},
    { stage: "G15", nama_gejala: "Sakit kepala yang tiba-tiba"},
    { stage: "G16", nama_gejala: "Tiba-tiba kehilangan kesadaran, keseimbangan, koordinasi, kontrol tubuh, dan bicara tidak jelas"},
    { stage: "G17", nama_gejala: "Kelemahan dan kelumpuhan pada beberapa bagian tubuh (wajah, lengan, tangan, terutama pada salah satu sisi tubuh)"},
    { stage: "G18", nama_gejala: "Penyakit infeksi saluran pernapasan (flu atau pilek)"},
    { stage: "G19", nama_gejala: "Keluar lendir dari rongga hidung terus menerus yang berwarna kemerahan"},
    { stage: "G20", nama_gejala: "Pembengkakan pada pergelangan kaki, kaki, dan tungkai kiri serta kanan"},
    { stage: "G21", nama_gejala: "Terlalu cepat ejakulasi"},
    { stage: "G22", nama_gejala: "Kesulitan memulai dan mempertahankan ereksi"},
]

questions.each do |q|
    Question.create(q)
end

Disease.create!([
    {code_penyakit: "P01", nama_penyakit: "Kanker Mulut"},
    {code_penyakit: "P02", nama_penyakit: "Kanker Tenggorokan"},
    {code_penyakit: "P03", nama_penyakit: "Kanker Paru-Paru"},
    {code_penyakit: "P04", nama_penyakit: "Kanker Payudara"},
    {code_penyakit: "P05", nama_penyakit: "Kanker Kandung Kemih"},
    {code_penyakit: "P06", nama_penyakit: "Stroke"},
    {code_penyakit: "P07", nama_penyakit: "Bronkitis"},
    {code_penyakit: "P08", nama_penyakit: "Impotensi"},
])

Kesimpulan.create([
    {stage: "G01", code_penyakit: "P01"},
    {stage: "G02", code_penyakit: "P01"},
    {stage: "G03", code_penyakit: "P01"},
    {stage: "G04", code_penyakit: "P01"},
    {stage: "G01", code_penyakit: "P02"},
    {stage: "G02", code_penyakit: "P02"},
    {stage: "G05", code_penyakit: "P02"},
    {stage: "G06", code_penyakit: "P02"},
    {stage: "G07", code_penyakit: "P02"},
    {stage: "G14", code_penyakit: "P02"},
    {stage: "G15", code_penyakit: "P02"},
    {stage: "G16", code_penyakit: "P02"},
    {stage: "G08", code_penyakit: "P03"},
    {stage: "G09", code_penyakit: "P03"},
    {stage: "G10", code_penyakit: "P03"},
    {stage: "G11", code_penyakit: "P04"},
    {stage: "G12", code_penyakit: "P04"},
    {stage: "G13", code_penyakit: "P05"},
    {stage: "G14", code_penyakit: "P05"},
    {stage: "G15", code_penyakit: "P06"},
    {stage: "G16", code_penyakit: "P06"},
    {stage: "G17", code_penyakit: "P06"},
    {stage: "G09", code_penyakit: "P07"},
    {stage: "G18", code_penyakit: "P07"},
    {stage: "G19", code_penyakit: "P07"},
    {stage: "G20", code_penyakit: "P07"},
    {stage: "G21", code_penyakit: "P08"},
    {stage: "G22", code_penyakit: "P08"},
])