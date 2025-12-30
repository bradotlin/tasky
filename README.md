# Tasky

A lightweight, modern task management web application built with Go and MongoDB. Tasky provides a clean interface for creating, managing, and tracking your todos with user authentication and a responsive web UI.

## Features

- 🔐 **User Authentication** - Secure JWT-based authentication system
- ✅ **Task Management** - Create, read, update, and delete tasks
- 👤 **User-specific Todos** - Each user has their own isolated task list
- 🌐 **RESTful API** - Clean API endpoints for all operations
- 🎨 **Modern Web UI** - Responsive HTML/CSS/JavaScript frontend
- 🐳 **Docker Support** - Containerized deployment ready
- ☸️ **Kubernetes Ready** - K8s manifests included for production deployment

## Technology Stack

- **Backend**: Go 1.18+
- **Web Framework**: [Gin](https://github.com/gin-gonic/gin)
- **Database**: MongoDB
- **Authentication**: JWT tokens
- **Password Hashing**: bcrypt
- **Frontend**: HTML, CSS, JavaScript

## Prerequisites

Before running Tasky, ensure you have the following installed:

- Go 1.18 or higher
- MongoDB 4.0 or higher
- Docker (optional, for containerized deployment)
- Kubernetes cluster (optional, for K8s deployment)

## Environment Variables

The following environment variables are required:

| Variable | Purpose | Example |
|----------|---------|---------|
| `MONGODB_URI` | MongoDB connection string | `mongodb://servername:27017` or `mongodb://username:password@hostname:port` or `mongodb+srv://` schema |
| `SECRET_KEY` | Secret key for JWT token signing | `your-secret-key-here` |

You can set these as system environment variables or create a `.env` file in the project root.

## Getting Started

### Running with Go

1. **Clone the repository**
   ```bash
   git clone https://github.com/bradotlin/tasky.git
   cd tasky
   ```

2. **Install dependencies**
   ```bash
   go mod tidy
   ```

3. **Create a `.env` file** in the project root with your environment variables:
   ```env
   MONGODB_URI=mongodb://localhost:27017
   SECRET_KEY=your-secret-key-here
   ```

4. **Run the application**
   ```bash
   go run main.go
   ```

5. **Access the application**
   
   Open your browser and navigate to `http://localhost:8080`

### Running with Docker

A Dockerfile is provided for containerized deployment. The application exposes port 8080 by default.

1. **Build the Docker image**
   ```bash
   docker build -t tasky .
   ```

2. **Run the container**
   ```bash
   docker run -p 8080:8080 \
     -e MONGODB_URI=mongodb://your-mongo-host:27017 \
     -e SECRET_KEY=your-secret-key \
     tasky
   ```

## API Endpoints

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/signup` | Create a new user account |
| POST | `/login` | Login and receive JWT token |

### Todo Operations

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Serve the login page |
| GET | `/todo` | Serve the todo management page |
| GET | `/todos/:userid` | Get all todos for a user |
| GET | `/todo/:id` | Get a specific todo by ID |
| POST | `/todo/:userid` | Create a new todo |
| PUT | `/todo` | Update an existing todo |
| DELETE | `/todo/:userid/:id` | Delete a specific todo |
| DELETE | `/todos/:userid` | Delete all todos for a user |

## Deployment

### Kubernetes Deployment

Kubernetes manifests are provided in the `app-k8s` directory for production deployment.

1. **Create a Docker image for K8s**
   ```bash
   # Build for linux/amd64 platform
   docker build -t tasky --platform=linux/amd64 .
   
   # Tag the image
   docker tag tasky:latest your-registry/tasky:latest
   
   # Push to your container registry
   docker push your-registry/tasky:latest
   ```

2. **Deploy to Kubernetes**
   ```bash
   cd app-k8s
   ./k8s.sh
   ```

3. **Delete K8s resources**
   ```bash
   cd app-k8s
   ./k8s_delete.sh
   ```

The K8s deployment includes:
- Application deployment (`tasky-app.yaml`)
- MongoDB deployment (`tasky-db.yaml`)
- Service account configuration (`svc-acct.yaml`)
- Secrets management (`tasky-secret.yaml`)
- HTTPS ingress configuration (`tasky-https.yaml`)

## Project Structure

```
tasky/
├── assets/          # Frontend HTML, CSS, JavaScript files
├── auth/            # Authentication and JWT utilities
├── controllers/     # HTTP request handlers
├── database/        # MongoDB connection and initialization
├── models/          # Data models (Todo, User)
├── app-k8s/         # Kubernetes deployment manifests
├── main.go          # Application entry point
├── go.mod           # Go module dependencies
├── Dockerfile       # Docker container definition
└── README.md        # This file
```

## Development

To contribute to Tasky:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## License

This project is licensed under the terms of the MIT license.

## Acknowledgments

Original project: [golang-todo-mongodb](https://github.com/dogukanozdemir/golang-todo-mongodb) by dogukanozdemir
