import tseslint from 'typescript-eslint';

export default tseslint.config({
    ignores: ['dist', 'node_modules'],
    files: ['**/*.ts'],
    languageOptions: {
        parser: tseslint.parser,
        parserOptions: {
            ecmaVersion: 'latest',
            sourceType: 'module',
            project: './tsconfig.json',
        },
    },
    plugins: {
        '@typescript-eslint': tseslint.plugin,
    },
    rules: {
        'no-unused-vars': 'off',
        '@typescript-eslint/no-unused-vars': ['error'],
    },
});
