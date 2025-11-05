FROM node:18

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your source code
COPY . .

# Generate Prisma client before migrate/build
RUN npx prisma generate

# NOTE: running migrations during image build tries to connect to the database
# which is not available during docker image build time (causes P1001 errors).
# Move migration execution to container startup or run migrations manually
# after the DB service is up (see project README or run:
#   docker-compose up -d mysql
#   docker-compose run --rm node-app npm run migrate
# Keeping migrations out of the build step ensures image builds are reproducible
# and don't depend on external services.

# Build TypeScript
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
