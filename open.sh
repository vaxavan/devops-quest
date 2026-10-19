#!/bin/bash
# Открывает следующий уровень квеста. Использование: bash open.sh НОМЕР
n="$1"
if [ -z "$n" ]; then
  echo "Использование: bash open.sh НОМЕР_УРОВНЯ   (например: bash open.sh 2)"
  exit 1
fi
f="levels/level$n.enc"
if [ ! -f "$f" ]; then
  echo "Уровня $n нет. Ты точно в папке квеста? (pwd)"
  exit 1
fi
read -r -p "Пароль от уровня $n: " p
if openssl enc -d -aes-256-cbc -pbkdf2 -a -in "$f" -pass pass:"$p" 2>/dev/null | tar -xz 2>/dev/null; then
  echo "Открыто! Заходи: cd level$n"
  echo "Посмотри, что внутри (ls), и прочитай задание: cat task.txt"
else
  rm -rf "level$n"
  echo "Неверный пароль. Попробуй ещё раз!"
fi
