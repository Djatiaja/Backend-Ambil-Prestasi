FROM node:18

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your source code
COPY . .

# Generate Prisma client before migrate/build
RUN npx prisma generate

# Run migrations (now the schema exists inside container)
RUN npm run migrate

# Build TypeScript
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
