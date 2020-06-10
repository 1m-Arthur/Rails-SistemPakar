class WebhookController < ApplicationController
    def index
        question = Question.all
        render json: question
    end

    def hooks
        body = request.body.read

        signature = request.env['HTTP_X_LINE_SIGNATURE']
        unless client.validate_signature(body, signature)
            halt 400, {'Content-Type' => 'text/plain'}, 'Bad Request'
        end

        events = client.parse_events_from(body)

        # EventLog.create(signature: signature, events: events, created_at: Time.now, updated_at: Time.now)

        events.each do |event|
        case event
            when Line::Bot::Event::Message
                handle_message(event)
            when Line::Bot::Event::Follow
                if event['source']['type'] == 'user'
                    profile = client.get_profile(event['source']['userId'])
                    profile = JSON.parse(profile.read_body)
                    reply_text(event, "Hai #{profile['displayName']}, Terimakasih telah menambahkan kami sebagai teman. \n\n"+
                        "Jika kalian ingin tau mengenai kami kalian bisa kenalan dengan kami dengan ketik \"about us\". \n\n"+
                        "Ketik \"mulai\" untuk memulai diagnosa"
                    )
                    User.create(user_id: profile['userId'], display_name: profile['displayName'], number_stage: "G01", created_at: Time.now, updated_at: Time.now)
                else
                    reply_text(event, "Bot can't use profile API without user ID")
                end
            when Line::Bot::Event::Postback
                profile = client.get_profile(event['source']['userId'])
                profile = JSON.parse(profile.read_body)
                postbackData = event['postback']['data']
                curUser = User.where(user_id: profile['userId']).order(id: :asc).last

                if (postbackData == "G23")
                    return reply_text(event, ["anda saat ini tidak terdeteksi terkena penyakit perokok", "Terimakasih telah menggunakan kami, ketik \"mulai\" untuk memulai kembali dari awal"])
                end

                if (event['postback']['data'] != "finish")
                    kes = Kesimpulan.where(stage: postbackData).first
                    if curUser.hasil == "P05"
                        kes = Kesimpulan.where(stage: postbackData).last
                    end
                    user = User.find_by(user_id: profile['userId'])
                    user.update(number_stage: postbackData, hasil: kes.code_penyakit) 
                else
                    kes = Kesimpulan.where(stage: curUser.number_stage).first
                    if curUser.hasil == "P05"
                        kes = Kesimpulan.where(stage: curUser.number_stage).last
                    end
                end
                puts postbackData
                if (postbackData == "G02")
                    return reply_postback(event, postbackData, "G03", "G03")
                elsif (postbackData == "G03")
                    return reply_postback(event, postbackData, "G04", "G05")
                elsif (postbackData == "G04")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "G05")
                    return reply_postback(event, postbackData, "G06")
                elsif (postbackData == "G06")
                    return reply_postback(event, postbackData, "G07")
                elsif (postbackData == "G07")
                    return reply_postback(event, postbackData, "G14")
                elsif (postbackData == "G08")
                    return reply_postback(event, postbackData, "G09", "G11")
                elsif (postbackData == "G09")
                    return reply_postback(event, postbackData, "G10")
                elsif (postbackData == "G10")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "G11")
                    return reply_postback(event, postbackData, "G12", "G13")
                elsif (postbackData == "G12")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "G13")
                    return reply_postback(event, postbackData, "G14", "G15")
                elsif (postbackData == "G14")
                    if curUser.hasil == "P05"
                        return reply_postback(event, postbackData)
                    else
                        return reply_postback(event, postbackData, "G15")
                    end
                elsif (postbackData == "G15")
                    return reply_postback(event, postbackData, "G16", "G18")
                elsif (postbackData == "G16")
                    if curUser.hasil == "P02"
                        return reply_postback(event, postbackData)
                    else
                        return reply_postback(event, postbackData, "G17")
                    end
                elsif (postbackData == "G17")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "G18")
                    return reply_postback(event, postbackData, "G19", "G21")
                elsif (postbackData == "G19")
                    return reply_postback(event, postbackData, "G20")
                elsif (postbackData == "G20")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "G21")
                    return reply_postback(event, postbackData, "G22", "G23")
                elsif (postbackData == "G22")
                    return reply_postback(event, postbackData)
                elsif (postbackData == "finish")
                    dizz = Disease.where(code_penyakit: kes.code_penyakit).first
                    reply_text(event, [
                        "anda kemungkinan terkena #{dizz.nama_penyakit}",
                        "Terimakasih telah menggunakan kami, ketik \"mulai\" untuk memulai kembali dari awal"
                    ])
                end
                
            else
                reply_text(event, "Aku tidak tau maksud dari apa yang kalian lakukan :(")
            end
        end   
        render plain: "OK"
    end

    private
    def client
        @client ||= Line::Bot::Client.new do |config|
            config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
            config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
            config.http_options = {
                open_timeout: 5,
                read_timeout: 5,
            }
        end
    end

    def reply_text(event, texts)
        texts = [texts] if texts.is_a?(String)
        client.reply_message(
            event['replyToken'],
            texts.map { |text| {type: 'text', text: text} }
        )
    end

    def reply_content(event, messages)
        res = client.reply_message(
            event['replyToken'],
            messages
            )
        logger.warn res.read_body unless Net::HTTPOK === res
        res
    end

    def reply_postback(event, stage, opsi1 = "finish", opsi2 = opsi1)

        myQuestion = Question.where(:stage => stage).first
        
        res = client.reply_message(
            event['replyToken'],
            {
                type: 'template',
                altText: "Confirm #{myQuestion.nama_gejala}",
                template: {
                    type: 'confirm',
                    text: "#{myQuestion.nama_gejala}?",
                    actions: [
                        { label: 'Yes', type: 'postback', data: "#{opsi1}" },
                        { label: 'No', type: 'postback', data: "#{opsi2}" },
                    ]
                }
            })
        logger.warn res.read_body unless Net::HTTPOK === res
        res
    end
    

    def handle_message(event)
        case event.type
        when Line::Bot::Event::MessageType::Text
            eventMsgText = event.message['text'].downcase!
            profile = client.get_profile(event['source']['userId'])
            profile = JSON.parse(profile.read_body)
            checkStage = User.where(:user_id => profile['userId']).order(id: :DESC).first
            if (eventMsgText.include? "about us")
                return reply_text(
                                    event, 
                                    "Kami adalah bot yang dibuat dari bahasa pemrograman Ruby. \n\n"+
                                    "Data kami berdasarkan penelitian oleh Yasmiyati dari Fakultas Komunikasi dan Informatika Universitas Muhammadiyah Surakarta. \n"+ 
                                    "dengan judul Sistem Pakar Diagnosis Penyakit pada Perokok dengan Metode FORWARD CHAINING berbasis Web. \n"
                                )
            elsif (eventMsgText.include? "mulai")
                checkStage.number_stage = "G01"
                reply_postback(event, checkStage.number_stage, "G02", "G08")
            else
                reply_text(event, "kalimat tidak dikenal :3 ")
            end
        end
    end
end
