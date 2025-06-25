#!/bin/bash

# Установка переменной окружения для неинтерактивной установки
export DEBIAN_FRONTEND=noninteractive

echo "
    _________    ____  __  _____________  _____     ____  ___   ____ 
   / ____/   |  / __ \/  |/  / ____/ __ \/ ___/    / __ \/   | / __ \\
  / /_  / /| | / /_/ / /|_/ / __/ / /_/ /\__ \    / / / / /| |/ / / /
 / __/ / ___ |/ _, _/ /  / / /___/ _, _/___/ /   / /_/ / ___ / /_/ / 
/_/   /_/  |_/_/ |_/_/  /_/_____/_/ |_|/____/   /_____/_/  |_\____/  

"

echo "Получаем обновления сервера..."
sudo apt update
echo "Устанавливаем обновления..."
sudo apt upgrade -y

# Install Google Chrome
echo "Устанавливаем Google Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install -y google-chrome-stable

# Проверка наличия Node.js
if ! command -v node &> /dev/null
then
    echo "Node.js не установлен. Устанавливаю Node.js v20..."
    # Установка Node.js версии 20.x
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js уже установлен."
fi

# Проверка наличия утилиты unzip
if ! command -v unzip &> /dev/null
then
    echo "Утилита unzip не установлена. Устанавливаю unzip..."
    sudo apt-get install -y unzip
else
    echo "Утилита unzip уже установлена."
fi

# Проверка наличия утилиты screen
if ! command -v screen &> /dev/null
then
    echo "Утилита screen не установлена. Устанавливаю screen..."
    sudo apt-get install -y screen
else
    echo "Утилита screen уже установлена."
fi

# Проверка наличия утилиты nano
if ! command -v nano &> /dev/null
then
    echo "Утилита screen не установлена. Устанавливаю nano..."
    sudo apt-get install -y nano
else
    echo "Утилита nano уже установлена."
fi

# Download and extract TG_SNIPER
echo "Скачиваю TG_SNIPER..."
wget -O TG_SNIPER.zip http://tekkaido.com/files/TG_SNIPER.zip

echo "Распаковываю TG_SNIPER..."
unzip TG_SNIPER.zip
rm TG_SNIPER.zip
cd TG_SNIPER

# Skip Puppeteer Chrome download
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Install npm dependencies
echo "Устанавливаю npm зависимости..."
npm install

# Run the application
echo "Запускаю TG_Sniper..."
node tg_sniper menu
