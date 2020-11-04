require 'text-table'
require_relative 'back'

markets = set_markets

puts 'Ejercicio de Felipe Apablaza'
puts ' '

markets.each_with_index do |market, index|
    puts '['+index.to_s+']: '+markets[index]
end

puts '['+markets.length.to_s+']: TODOS'
puts ' '
print 'Ingresa el número del mercado: '

answer = gets.chomp.to_i

puts ' '
puts 'el resultado puede tardar unos segundos ...'
puts ' '

table = [[ "Mercado", "Monto", "Precio", "Tipo", "Timestamp"]]

if (answer == markets.length)
    time_now, time_yesterday = set_times
    markets.each_with_index do |market, index|
        name = markets[index]
        trades = set_trades name, time_now, time_yesterday
        best = find_best_trade trades
        table.concat([[name, best[1], best[2], best[3], Time.at(best[0].to_i/1000)]])
    end 
elsif (answer >= 0 && answer < 19)
    time_now, time_yesterday = set_times
    name = markets[answer]
    trades = set_trades name, time_now, time_yesterday
    best = find_best_trade trades
    table.concat([[name, best[1], best[2], best[3], Time.at(best[0].to_i/1000)]])
else 
    puts 'Error'
    exit
end

puts table.to_table(:first_row_is_head => true)


