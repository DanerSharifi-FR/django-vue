# Django + Vue Dockerized Starter

Welcome to your **Django + Vue** full‑stack starter kit! This README walks you through both **development** and **production** workflows, so you can get up and running quickly and ship rock‑solid releases.

---

## 📁 Repository Structure

```
├── backend/                   # Django project
│   ├── Dockerfile             # Dev Dockerfile for Django + Gunicorn
│   ├── entrypoint.sh          # Migrations + collectstatic + start server
│   └── requirements.txt       # Python dependencies
│   └── backend/               # Django settings & URLs
│   └── api/                   # Your DRF app

├── frontend/                  # Vue 3 + Vite app
│   ├── Dockerfile             # Multi-stage build for production
│   ├── package.json           # npm scripts & deps
│   └── src/                   # Vue components & assets

├── docker-compose.yml         # Development compose (Django + Vite)
├── docker-compose.prod.yml    # Production compose (Django + Nginx + optional DB)
├── .env.backend               # Dev environment variables for Django
├── .env.backend.prod          # Prod environment variables for Django
└── README.md                  # This file
```

---

## 🚀 Development Workflow

Use this mode during feature development, hot‑reload, and testing.

1. **Clone & login**

   ```bash
   git clone git@github.com:<you>/django-vue-docker.git
   cd django-vue-docker
   ```

2. **Environment**

   * Ensure Docker Desktop (WSL2 backend) is running
   * Node.js & Python versions are irrelevant (all runs in containers)

3. **Run the stack**

   ```bash
   # THIS file runs Django in Docker and Vite hot‑reload in Docker
   docker-compose up --build
   ```

4. **Access**

   * **Backend (Django API)** → [http://localhost:8000](http://localhost:8000)
   * **Frontend (Vue Vite)**  → [http://localhost:5173](http://localhost:5173)

5. **Create superuser**

   ```bash
   docker-compose exec backend bash
   python manage.py createsuperuser
   exit
   ```

6. **Stop**

   ```bash
   docker-compose down
   ```

**Key points:**

* The `frontend` service uses the official Node image, mounts your code, runs `npm install` + `npm run dev`.
* Hot reload works out of the box.
* Django static files are served with WhiteNoise.

---

## 🔧 Production Workflow

Ship a lean, secure stack for production. You’ll need to prepare your `docker-compose.prod.yml` and `.env.backend.prod`.

1. **Build & publish frontend**

   ```bash
   cd frontend
   docker build -t <your-dockerhub>/vue-frontend:latest .
   docker push <your-dockerhub>/vue-frontend:latest
   ```

2. **Prepare environment files**

   * Create `.env.backend.prod` with your `SECRET_KEY`, `DEBUG=0`, DB credentials, etc.

3. **Start production stack**

   ```bash
   docker-compose -f docker-compose.prod.yml up -d --build
   ```

4. **Verify**

   * **Frontend** → [http://your.domain](http://your.domain) (served by nginx)
   * **Backend**  → [http://your.domain:8000](http://your.domain:8000) (or routed by proxy)

**Production tips:**

* Bake code into images—no source mounts.
* Serve static Vue build via Nginx.
* Use Docker secrets or a vault for sensitive env vars.
* Lock down `ALLOWED_HOSTS` and `CORS_ALLOWED_ORIGINS`.

---

## 📦 Available Commands

<details>
<summary>Development</summary>

```bash
# Start dev with hot‑reload
docker-compose up --build

# Stop all services
docker-compose down

# Run Django migrations inside container
docker-compose exec backend python manage.py migrate
```

</details>

<details>
<summary>Production</summary>

```bash
# Build & push frontend image
cd frontend && docker build -t <you>/vue-frontend:latest .

# Launch prod stack
docker-compose -f docker-compose.prod.yml up -d --build

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

</details>

---

## 🛠 Next Steps

* Build your **Todos API** with Django REST Framework
* Create **Vue components** that consume your endpoints
* Add **CI/CD**: lint, test, build, and push on GitHub Actions
* Hardening: **HTTPS**, **rate‑limiting**, **monitoring**

Feel free to tweak this README to match your project specifics. Happy coding! 🎉
