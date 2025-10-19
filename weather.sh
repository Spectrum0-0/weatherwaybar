#!/usr/bin/env bash

LAT="" # The latitude you desire
LON="" # The longitude you desire
API_KEY="" # Change this to your API key
UNIT="metric" # Metric or Imperial

data=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$API_KEY&units=$UNIT")

if [ ! -z "$data" ]; then
  temp=$(echo "$data" | jq ".main.temp" | xargs printf "%.0f")
  desc=$(echo "$data" | jq -r ".weather[0].main")
  icon=$(echo "$data" | jq -r ".weather[0].icon")

  # Optional: small icon mapping
  case $icon in
    01d) weather_icon="☀️" ;;
    01n) weather_icon="🌙" ;;
    02*) weather_icon="⛅" ;;
    03*|04*) weather_icon="☁️" ;;
    09*|10*) weather_icon="🌧️" ;;
    11*) weather_icon="⛈️" ;;
    13*) weather_icon="❄️" ;;
    50*) weather_icon="🌫️" ;;
    *) weather_icon="🌈" ;;
  esac

  echo "${weather_icon} ${temp}°C"
else
  echo "Weather: N/A"
fi
