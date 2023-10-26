# FBX

This is a simple Flask application for managing and viewing posts in a social network. The application provides RESTful API endpoints for creating and viewing posts, along with the ability to tag friends in posts. It uses a MySQL database to store post data.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [API Endpoints](#api-endpoints)


## Features

- Create new posts with content and optional location and tagged friends.
- View all posts.
- View posts by a specific user.
- View posts from a specific location.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Python >= 3.7 installed.
- Required Python packages installed. You can install them using `pip install -r requirements.txt`.
- MySQL server running with the specified database and configurations.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/G06-SDPX/UML.git
   cd UML
   ```
2. Build and start the project using Docker Compose:

   ```bash
   docker-compose up -d --build
   ```
   or
    ```bash
   docker-compose up -d
   ```
3. Access the application in your web browser or via the provided endpoint

## Usage

The API has the following endpoints:

 - POST /post: Create a new post.
 - GET /view: View all posts.
 - GET /view/user/<user_id>: View posts by a specific user.
 - GET /view/location/<location_id>: View posts at a specific location.

