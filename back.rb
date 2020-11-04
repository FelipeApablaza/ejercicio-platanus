require 'faraday'
require 'json'

# ---------- api requests methods ----------

$api_url = 'https://www.buda.com/api/v2'

def get_markets_request
    response = Faraday.get($api_url+'/markets')
    response = JSON.parse(response.body)['markets']  
    return response
end

def get_trades_request market_id, current_timestamp
    timestamp = 'timestamp='+current_timestamp.to_s
    limit = 'limit=100'
    trades_url = $api_url+'/markets/'+market_id+'/trades?'+timestamp+'&'+limit
    response = Faraday.get(trades_url)
    response = JSON.parse(response.body)['trades']
    return response
end

# -------------- other methods --------------

def set_markets
    markets = {}
    response = get_markets_request
    response.each_with_index do |market, index|
        markets[index] = market["id"] 
    end
    return markets
end

def set_times
    time_now = Time.now.to_i * 1000
    time_yesterday = time_now - ( 60 * 60 * 24 * 1000)
    return time_now, time_yesterday
end

def set_trades market_id, time_now, time_yesterday
    current_timestamp = time_now
    trades = []
    while current_timestamp > time_yesterday
        response = get_trades_request market_id, current_timestamp
        current_timestamp = response['last_timestamp'].to_i
        if (current_timestamp > time_yesterday)
            trades.concat(response['entries'])
        else
            response['entries'].each do |entry|
                if (entry[0].to_i > time_yesterday)
                    trades.push(entry)
                else
                    break
                end
            end
        end
    end
    return trades
end

def find_best_trade trades
    sorted_trades = trades.sort_by { |trade| trade[1].to_f }.reverse
    best_trade = sorted_trades[0]
    return best_trade
end 
