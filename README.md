# StockYa AI - Frontend

Aplicación web de StockYa AI para el control de inventario: login, dashboard, categorías, productos, movimientos de stock, usuarios y asistente de consultas. Consume la API REST del backend de StockYa.

## Tecnologías

React 19, React Router 7 y Vite. En producción se sirve con Vercel o con nginx en Docker.

## Ejecutar en local

Requisitos: Node.js 22 o superior y el backend corriendo en `http://localhost:8080`.

```bash
npm install
npm run dev        # http://localhost:5173
```

Build de producción (genera `dist/`):

```bash
npm run build
npm run preview
```

## Configuración

Copiar `.env.example` a `.env` si hace falta cambiar algo.

| Variable | Desarrollo | Producción | Descripción |
|---|---|---|---|
| `VITE_API_URL` | `/api` | `/api` | URL base de la API. Con `/api` las peticiones pasan por un proxy que quita el prefijo y las reenvía al backend, así se evita CORS. También acepta una URL completa del backend (por ejemplo `https://stockya-vys0.onrender.com`); en ese caso el backend debe permitir CORS. |
| `VITE_PROXY_TARGET` | `http://localhost:8080` | no aplica | Destino del proxy de Vite en `npm run dev`. |

Las variables `VITE_*` se leen en tiempo de build, así que cualquier cambio exige volver a compilar.

En producción el proxy de `/api` lo hace:

- Vercel, con la regla de `vercel.json` que apunta a `https://stockya-vys0.onrender.com`.
- nginx, en la imagen Docker. El destino se define con la variable `BACKEND_URL` (por defecto `https://stockya-vys0.onrender.com`).

## Docker

```bash
docker build -t stockya-front .
docker run -p 8081:80 stockya-front
# con otro backend:
docker run -p 8081:80 -e BACKEND_URL=http://host.docker.internal:8080 stockya-front
```

## Asistente

`src/services/asistente.js` tiene la bandera `USE_MOCK = true` y responde con datos simulados. Cuando el backend exponga `POST /asistente/consultar`, cambiarla a `false`.

## Despliegue

- Vercel: el proyecto se importa desde este repositorio con la configuración de Vite por defecto (`npm run build`, carpeta `dist`). `vercel.json` se encarga del proxy y de las rutas del SPA.
- Imagen Docker: con cada push a `main`, el workflow `.github/workflows/frontend.yml` construye la imagen y la publica en `ghcr.io/<usuario>/<repositorio>`.

## Usuarios de prueba

- `admin@stockya.com` / `Admin123!` (Administrador)
- `almacen@stockya.com` / `Almacen123!` (Almacenero)
