# 📅 Reminder

Aplicación móvil multiplataforma desarrollada en **Flutter** para crear y gestionar recordatorios de eventos de manera sencilla.  
Los recordatorios se guardan en la nube y las **notificaciones se envían desde el servidor a través de Supabase**.

---

## ✨ Características

- ➕ Crear, editar recordatorios de eventos
- 💾 Almacenar y gestionar información de **sectores y centros poblados** en la base de datos  
- 🔔 Notificaciones push enviadas desde el servidor  
- 📱 Interfaz intuitiva y amigable  
- ⚡ Multiplataforma (Android / iOS / Web)  
- ☁️ Sincronización en la nube con **Supabase**  

---

## 📸 Capturas de pantalla

 ![WhatsApp Image 2025-02-01 at 11 33 09_c0ced0b2](https://github.com/user-attachments/assets/18dfdded-66b2-4601-87d4-8b3f38cac152)

![WhatsApp Image 2025-02-01 at 11 36 22_11efd73f](https://github.com/user-attachments/assets/277c924e-c591-4948-b7ba-70581d40306a)
![WhatsApp Image 2025-02-01 at 11 55 18_141f338e](https://github.com/user-attachments/assets/a22a4535-7e5c-48af-afa8-54bfc4564ed0)


---

## 🛠️ Tecnologías usadas

- [Flutter](https://flutter.dev/) (versión recomendada: `3.x.x`)  
- [Dart](https://dart.dev/)  
- [Supabase](https://supabase.com/)  
  - Base de datos para almacenar recordatorios  
  - Autenticación de usuarios  
  - Envío de notificaciones push desde el servidor  
- Paquetes principales:
  - `supabase_flutter`
  - `provider`
  - `path_provider`
---

## 🚀 Instalación

1. Clona el repositorio  
   ```bash
   git clone https://github.com/LuisB1717/reminder.git
   cd reminder
2. Instalar dependencias
   - flutter pub get
     
3. Configura tu proyecto de Supabase

    Crea un proyecto en Supabase
    
    Copia tu SUPABASE_URL y SUPABASE_ANON_KEY
    
    Agrega un archivo .env con:
    
    SUPABASE_URL=tu_url_aqui
    SUPABASE_ANON_KEY=tu_key_aqui

4. Correr proyecto:
  flutter run


📜 Licencia

Este proyecto está bajo la licencia MIT.
