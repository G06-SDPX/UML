# Diagram

## - [Class Diagram](https://github.com/G06-SDPX/UML/blob/main/class-diagram/class-diagram.pdf)
## - [Sequence Diagrams](https://github.com/G06-SDPX/UML/blob/main/sequence-diagrams/sequence-diagrams.pdf)

# FBX

This is a simple Flask application for managing and viewing posts in a social network. The application provides RESTful API endpoints for creating and viewing posts, along with the ability to tag friends in posts. It uses a MySQL database to store post data.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [API Endpoints](#api-endpoints)
- [Usage](#usage)
- [Database Tables](#database-tables)


## Features

- Create new posts with content and optional location and tagged friends.
- View all posts.
- View posts by a specific user.
- View posts from a specific location.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Docker Desktop >= 4.24.2 installed.
- Docker version >= 24.0.6 installed.
- Docker-Compose version >= 2.22.0 installed.
- Git version >= 2.41.0 installed.

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

## Database Tables (Mockup Data)

### Locations

| location_id | location_name     |
|------------ | ------------------|
| 1           | กรุงเทพ            |
| 2           | กระบี่              |
| 3           | เชียงใหม่           |
| 4           | เชียงราย           |
| ...         | ...               |

### Posts

| post_id | user_id | content                           | location_id |
| ------- | ------- | --------------------------------- | ----------- |
| 1       | 1       | สวัสดี, กรุงเทพ!                     | 1           |
| 2       | 2       | วันนี้อากาศดีมากในกระบี่                | 2           |
| ...     | ...     | ...                               | ...         |

### Posttags

| post_id | user_id |
| ------- | ------- |
| 1       | 1       |
| 2       | 2       |
| ...     | ...     |

### Users

| user_id | username |
| ------- | -------- |
| 1       | Mon      |
| 2       | Chid     |
| ...     | ...      |

