current_dir=$(pwd)
dir_name=$(basename "$current_dir")
dir_user=$(stat -c '%U' .)

cat <<EOF > /etc/systemd/system/heroku.service
[Unit]
Description=Auto Systemd by SunnexGB
After=network.target

[Service]
User=$dir_user
WorkingDirectory=$current_dir
ExecStart=/usr/bin/env python3 -m heroku --root
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "Конфиггурация создана!"
echo "Последние штрихи"

systemctl daemon-reload
systemctl start heroku
systemctl enable heroku

echo "Systemd работает, текущий статус:"
systemctl status heroku --no-pager | head -n 5
