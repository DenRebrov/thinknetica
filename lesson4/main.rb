require_relative "railway.rb"
require_relative "station.rb"
require_relative "route.rb"
require_relative "train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_train.rb"
require_relative "vagon.rb"
require_relative "cargo_vagon.rb"
require_relative "passenger_vagon.rb"

ACTIONS = [
  "Создать станцию",
  "Создать поезд",
  "Создать маршрут",
  "Назначаить маршрут поезду",
  "Создать вагон",
  "Прицепить вагон к поезду",
  "Отцепить вагон от поезда",
  "Переместить поезд по маршруту вперед",
  "Переместить поезд по маршруту назад",
  "Вывести список станций",
  "Вывести список поездов на станции"
]

railway = Railway.new

loop do
  ACTIONS.each.with_index(1) do |user_action, index|
    puts "#{index}. #{user_action}"
  end

  puts
  puts "Для управления, введи цифру действия от 1 до 11"
  puts "(0 - Выход)"

  user_choice = gets.chomp

  case user_choice
  when "1"
    railway.create_station
  when "2"
    railway.create_train
  when "3"
    railway.create_route
  when "4"
    railway.assign_route
  when "5"
    railway.create_wagon
  when "6"
    railway.hook_wagon
  when "7"
    railway.unhook_wagon
  when "8"
    railway.train_forward
  when "9"
    railway.train_backwards
  when "10"
    railway.stations_list
  when "11"
    railway.trains_list
  end

  break if user_choice == "0"
end
