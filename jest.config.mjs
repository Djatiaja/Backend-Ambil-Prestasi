const config = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testMatch: [
    "**/__tests__/**/*.ts",
    "**/?(*.)+(spec|test).ts"
  ],
  clearMocks: true,
  setupFiles: ['./jest.setup.js'],
};

export default config;
