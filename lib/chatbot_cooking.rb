require 'http'
require 'json'
require 'dotenv'
Dotenv.load("../.env")
api_key = ENV["OPENAI_API_KEY"]
url =  "https://api.openai.com/v1/completions"
puts "bienvenue au chatbot :"
puts "(quit pour partir)"
def renvoiegpt(url, api_key)
    print "Vous : "
    variable = gets.chomp.to_s
    if variable == "quit"
        exit
    end
    headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}" 
    }

    data = {
        "model" => "gpt-3.5-turbo-instruct",
        "prompt" => variable,
        "max_tokens" => 30,
        "temperature" => 0.1
    }

    response = HTTP.post(url, headers: headers, body: data.to_json)
    if response.code == 200
    response_body = JSON.parse(response.body.to_s)

    if response_body['choices'].is_a?(Array) && !response_body['choices'].empty?
        response_string = response_body['choices'][0]['text'].strip
        puts "IA : " + response_string
    else
        puts "Aucune réponse valide n'a été trouvée dans la réponse de l'API."
    end
    else
    puts "Erreur lors de la requête à l'API GPT-3 : #{response.code}"
    puts "Réponse brute de l'API :"
    puts response.body
    end
end

loop do 
    renvoiegpt(url, api_key)
end