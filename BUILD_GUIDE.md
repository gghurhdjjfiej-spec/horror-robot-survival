# Полное руководство по сборке APK

## 🚀 БЫСТРЫЙ СПОСОБ (Рекомендуется)

### Шаг 1: Комит кода
```bash
git add .
git commit -m "Game ready for build"
git push origin main
```

### Шаг 2: GitHub Actions
1. Перейти: https://github.com/gghurhdjjfiej-spec/horror-robot-survival
2. Вкладка **Actions**
3. Выбрать **Build APK**
4. Нажать **Run workflow**
5. Дождаться ✅

### Шаг 3: Скачать APK
1. Нажать на завершенный workflow
2. Раскрыть **Artifacts**
3. Скачать **horror-robot-survival.apk** (~150 MB)
4. Перенести на телефон
5. Установить

---

## 💻 Локальная сборка (Продвинуто)

### Установка зависимостей

#### Windows
```powershell
choco install openjdk11
choco install android-sdk
# Скачать Godot 4.1+ с godotengine.org
```

#### macOS
```bash
brew install openjdk@11
brew install --cask android-sdk
brew install godot
```

#### Linux
```bash
sudo apt-get install openjdk-11-jdk android-sdk
# Скачать Godot с godotengine.org
```

### Конфигурация Godot
1. Открить Godot
2. **Project → Export → Android** (+ Add Preset)
3. Настроить:
   - **Android SDK Path**: путь к SDK
   - **JDK Path**: путь к JDK
   - **Min SDK**: 21
   - **Target SDK**: 33
4. **Export Project** → выбрать папку
5. Дождаться сборки

### Командная строка
```bash
godot --headless --export-release "Android" ./build/game.apk
```

---

## 📱 Инсталляция на телефон

### Способ 1: Прямой файл (Простой)
1. Скопировать APK на телефон (USB/облако)
2. Открыть файловый менеджер
3. Нажать APK
4. Разрешить неизвестные источники
5. **Установить**
6. **Запустить**

### Способ 2: ADB (Надежный)
```bash
adb devices                # проверить подключение
adb install game.apk       # установить
adb shell am start -n com.horror.survival/.MainActivity  # запустить
```

### Способ 3: Облако
- Google Drive / Dropbox → скачать на телефон → установить

---

## 🔧 Требования

- **ОС**: Android 5.0+ (API 21+)
- **Место**: 300 MB
- **GPU**: OpenGL ES 3.0+
- **ОЗУ**: 2 GB минимум

---

## ❌ Решение проблем

| Проблема | Решение |
|---------|--------|
| Godot не находит SDK | Скачать через Editor → Manage Export Templates |
| APK не устанавливается | Проверить версию Android (5.0+) |
| Игра крашится | Снизить графику в Settings → Rendering |
| Медленная работа | Отключить эффекты в Project Settings |

---

## 📊 Размеры файлов

- Исходный код: ~5 MB
- С ассетами: ~150 MB
- Финальный APK: ~120-150 MB

---

## ✅ Готово!

Вы получите файл: `horror-robot-survival.apk`

Полностью готов к:
- Установке на любой Android
- Распространению в Google Play
- Публикации на itch.io
- Отправке друзьям
