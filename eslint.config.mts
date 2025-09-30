import eslint from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';
import jest from 'eslint-plugin-jest';

export default tseslint.config(
  {
    ignores: [
      '**/build/**',
      '**/tmp/**',
      '**/coverage/**',
      'jest.setup.js',
      'dist/**',
      '**/dist/**',
      '**/dist/tests/**', // Added to ignore compiled test files
    ],
  },
  eslint.configs.recommended,
  {
    extends: [...tseslint.configs.recommended],

    files: ['src/**/*.ts', 'src/**/*.mts'],

    plugins: {
      '@typescript-eslint': tseslint.plugin,
    },

    rules: {
      '@typescript-eslint/explicit-function-return-type': 'warn',
    },

    languageOptions: {
      parser: tseslint.parser,
      ecmaVersion: 2020,
      sourceType: 'module',

      globals: {
        ...globals.node,
      },

      parserOptions: {
      },
    },
  },
  {
    files: ['tests/**/*.ts', 'tests/**/*.mts', '**/*.test.ts', '**/*.spec.ts'],

    plugins: {
      jest,
    },

    rules: {
      ...jest.configs.recommended.rules,
    },

    languageOptions: {
      parser: tseslint.parser, // <-- Add this
      parserOptions: {
        ecmaVersion: 2020,
        sourceType: 'module',
        project: './tsconfig.json', // optional, enables type-aware linting
      },
      globals: {
        ...globals.jest,
        ...globals.node, // for process, etc.
      },
    },
  }

);
