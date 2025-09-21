import eslint from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';
import jest from 'eslint-plugin-jest';

export default tseslint.config(
  {
    ignores: ['**/build/**', '**/tmp/**', '**/coverage/**'],
  },
  eslint.configs.recommended,
  {
    extends: [...tseslint.configs.recommended],

    files: ['**/*.ts', '**/*.mts'],

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
    files: ['tests/**', '**/*.test.ts', '**/*.spec.ts'],

    plugins: {
      jest,
    },

    rules: {
      ...jest.configs.recommended.rules,
    },

    languageOptions: {
      globals: {
        ...globals.jest,
      },
    },
  },
);
