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
                    puts(profile)
                    # User.create(user_id: )
                else
                    reply_text(event, "Bot can't use profile API without user ID")
                end
            else
                reply_text(event, "Aku tidak tau maksud dari apa yang kalian lakukan :(")
            end
        end   
        "OK"
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

    def handle_message(event)
        case event.type
        when Line::Bot::Event::MessageType::Text
            eventMsgText = event.message['text'].downcase!
            if (eventMsgText.include? "about us")
                return reply_text(
                                    event, 
                                    "Kami adalah bot yang dibuat dari bahasa pemrograman Ruby. \n"+
                                    "Data kami berdasarkan penelitian oleh Yasmiyati dari Fakultas Komunikasi dan Informatika Universitas Muhammadiyah Surakarta. "+ 
                                    "dengan judul Sistem Pakar Diagnosis Penyakit pada Perokok dengan Metode FORWARD CHAINING berbasis Web. \n"
                                )
            elsif (eventMsgText.include? "mulai")
                
                # checkStage = 
                # stage = "G01"
                # if stage = 
                
                # end
                
                # return reply_text(event, "")
            end
        else
    
        end
    end
end
