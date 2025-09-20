<h1 align="center">Backend LMS Sekolah Alam</h1>

## Description  
This is a **Node.js backend project** built with **TypeScript, Express, and Prisma** to support the **Sekolah Alam Learning Management System (LMS)**.  
The platform focuses on delivering accessible education, particularly around **environmental awareness** and **food security**, for students in rural areas.  

## Key Features  
- **User Management**: Students, teachers, and volunteers.  
- **Learning Materials**: Delivery of videos, texts, and images.  
- **Collaboration**: Tools to enable community-based learning.  
- **Progress Tracking**: Monitor achievements and learning outcomes.  

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Scripts](#scripts)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Development Dependencies](#development-dependencies)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Linting](#linting)
- [Database Seeding](#database-seeding)
- [License](#license)

## Prerequisites
- Node.js (version 18 or higher)
- npm (version 8 or higher)
- TypeScript
- Prisma CLI
- A compatible database (e.g., PostgreSQL, MySQL) configured with Prisma

## Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up environment variables:
   - Create a `.env` file in the root directory.
   - Add necessary environment variables (e.g., `DATABASE_URL` for Prisma).
4. Run database migrations (if applicable):
   ```bash
   npx prisma migrate dev
   ```

## Scripts
The following npm scripts are available:
- `npm run dev`: Start the development server with nodemon, watching for changes in the `src` directory.
- `npm run build`: Compile TypeScript files to JavaScript in the `dist` directory.
- `npm run start`: Run the compiled application from the `dist` directory.
- `npm run test`: Run all tests (unit and feature) using Jest in test environment.
- `npm run test:unit`: Run only unit tests.
- `npm run test:feature`: Run only feature tests.
- `npm run seed`: Run the database seed script.
- `npm run lint`: Lint the codebase using ESLint.
- `npm run prepare`: Set up Husky for Git hooks.

## Project Structure
```
.
├── .husky/                 # Husky Git hooks configuration
│   ├── commit-msg         # Commit message validation hook
│   └── pre-commit         # Pre-commit linting hook
├── src/                   # Source code
│   ├── api/
│   │   └── v1/           # API version 1
│   │       ├── controllers/  # API controllers
│   │       ├── helpers/      # Utility functions
│   │       ├── middlewares/  # API middlewares
│   │       ├── models/       # Data models
│   │       ├── routes/       # API routes
│   │       ├── services/     # Business logic
│   │       └── validations/  # Input validations
│   ├── config/           # Configuration files
│   ├── database/         # Database-related files
│   │   ├── migrations/   # Prisma migrations
│   │   ├── seeders/      # Database seed scripts
│   │   ├── index.ts      # Database connection
│   │   ├── schema.prisma # Prisma schema
│   │   └── seed.ts       # Main seed script
│   ├── index.ts          # Application entry point
│   └── server.ts         # Express server setup
├── tests/                # Test files
│   ├── feature/          # Feature/integration tests
│   ├── unit/             # Unit tests
├── .env                  # Environment variables (development)
├── .env.prod             # Environment variables (production)
├── .env.test             # Environment variables (testing)
├── .eslintignore         # ESLint ignore configuration
├── .gitignore            # Git ignore file
├── .gitlab-ci.yml        # GitLab CI/CD configuration
├── commit-standardization.md  # Commit message guidelines
├── commitlint.config.js  # Commitlint configuration
├── eslint.config.js      # ESLint configuration (JavaScript)
├── eslint.config.mts     # ESLint configuration (TypeScript)
├── jest.config.ts        # Jest configuration
├── package.json          # Project metadata and scripts
├── package-lock.json     # Dependency lock file
├── prisma.config.ts      # Prisma configuration
├── README.md             # Project documentation
└── tsconfig.json         # TypeScript configuration
```

## Dependencies
- `@ngneat/falso`: For generating fake data during seeding or testing.
- `@prisma/client`: Prisma ORM for database interactions.
- `express`: Web framework for building the API.
- `prisma`: Prisma CLI for database migrations and schema management.

## Development Dependencies
- `@commitlint/cli`, `@commitlint/config-conventional`: Enforce conventional commit messages.
- `@eslint/js`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`, `eslint`, `eslint-plugin-jest`, `globals`: Linting and code quality tools.
- `@types/*`: TypeScript type definitions for Express, Jest, Node, and Supertest.
- `husky`: Git hooks for automated linting and commit validation.
- `jest`, `ts-jest`, `supertest`: Testing framework and utilities.
- `nodemon`, `ts-node`: Development tools for running TypeScript files.
- `typescript`, `typescript-eslint`: TypeScript and its ESLint integration.

## Running the Application
1. **Development Mode**:
   ```bash
   npm run dev
   ```
   This starts the server with nodemon, automatically restarting on file changes.

2. **Production Mode**:
   ```bash
   npm run build
   npm run start
   ```

## Testing
Run all tests:
```bash
npm run test
```
Run specific tests:
```bash
npm run test:unit
npm run test:feature
```

## Linting
Check code quality with ESLint:
```bash
npm run lint
```

## Database Seeding
Populate the database with initial data:
```bash
npm run seed
```

## License
This project is licensed under the ISC License.
