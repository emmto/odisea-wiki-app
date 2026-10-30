# 🍌 La Odisea del Pan de Plátano - Wiki App

Aplicación móvil complementaria (Wiki) para el videojuego **La Odisea del Pan de Plátano**, desarrollada en **Flutter** con backend en la nube mediante **Google Firebase**.

Proyecto académico desarrollado para la materia de **Desarrollo Móvil (IDGS - Unidad 2)** en la **Universidad Tecnológica de Nayarit**.

---

## 🎨 Identidad Visual y Manual de Marca

La interfaz sigue fielmente la guía de estilo artesanal y culinaria del juego:

* **Paleta Cromática Oficial**:
  * 🟡 **Amarillo Plátano (`#F5B731`)**: Color primario de énfasis, botones de acción (CTA) y badges activos.
  * 🟫 **Café Panadería (`#2B1E16`)**: Color de texto, íconos y contraste fuerte (cumple WCAG AAA).
  * 🌾 **Crema Harina de Trigo (`#FBF8F2`)**: Fondo base de la aplicación.
  * 🌿 **Verde Manglar (`#2E5A44`)**: Color secundario para estados de éxito, aliados y navegación costera.
  * 🍞 **Beige Masa (`#E8E0D2`) / Top Bar (`#EFE7D8`)**: Superficie de tarjetas y barras de navegación.
* **Tipografías**:
  * **Outfit**: Títulos, encabezados y botones de acción.
  * **Rubik**: Textos de lectura, subtítulos y formularios.
* **Logotipo**: *La Hogaza Dorada* en contenedor squircle con relieve suave.

---

## 🚀 Características Implementadas (Módulo de Acceso y Autenticación)

- [x] **Inicio de Sesión (Sign In)** con validación de credenciales en tiempo real.
- [x] **Registro de Nuevos Panaderos (Sign Up)** con validación de campos obligatorios, prevención de duplicados y creación de perfil en base de datos.
- [x] **Recuperación de Contraseña (Forgot Password)** mediante envío de correo seguro con enlace criptográfico vía Firebase Authentication.
- [x] **Persistencia de Sesión** con `StreamBuilder` reactivo (`AuthWrapper`).
- [x] **Traducción amigable de excepciones** de autenticación al español.
- [x] **Cierre de sesión seguro** con diálogo de confirmación.

---

## 🛠️ Tecnologías y Dependencias

* **Framework:** [Flutter](https://flutter.dev/) (SDK Dart 3.13+)
* **Backend:** [Firebase Authentication](https://firebase.google.com/docs/auth) & [Cloud Firestore](https://firebase.google.com/docs/firestore)
* **Fuentes:** [Google Fonts](https://pub.dev/packages/google_fonts) (`outfit`, `rubik`)
* **Plataformas Soportadas:** Android (APK móvil) & Web (Hosting)

---

## ⚙️ Configuración y Ejecución Local

### Prerrequisitos
* Flutter SDK (3.24+ o superior).
* Dispositivo Android conectado con Depuración USB o Emulador Android.

### Instalación
```bash
# 1. Clonar el repositorio
git clone https://github.com/TU_USUARIO/odisea_wiki_app.git
cd odisea_wiki_app

# 2. Descargar paquetes de dependencias
flutter pub get

# 3. Ejecutar la aplicación en modo desarrollo
flutter run
```

---

## 👥 Equipo de Desarrollo
* **Cervantes Ramírez José Eduardo**
* **López Cabrera Luis Daniel**
* **Peña Arvizu Jorge Gabriel**
* **Torres Rodríguez Emmanuel**
* **Velazquez Meza Axel**

**Profesor Titular:** Ing. César Emmanuel Jiménez Soto  
**Institución:** Universidad Tecnológica de Nayarit — Ingeniería en Desarrollo y Gestión de Software (IDGS)
