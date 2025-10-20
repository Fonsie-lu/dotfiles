import servicenow from 'eslint-plugin-servicenow';
import jsdoc from 'eslint-plugin-jsdoc';
import prettier from 'eslint-plugin-prettier';
import globals from 'globals';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import js from '@eslint/js';
import { FlatCompat } from '@eslint/eslintrc';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
    baseDirectory: __dirname,
    recommendedConfig: js.configs.recommended,
    allConfig: js.configs.all
});

export default [
    ...compat.extends('standard', 'plugin:prettier/recommended'),
    {
        plugins: {
            servicenow,
            jsdoc,
            prettier
        },

        languageOptions: {
            globals: {
                ...globals.prototypejs
            },

            ecmaVersion: 12,
            sourceType: 'script',

            parserOptions: {
                ecmaFeatures: {}
            }
        },

        rules: {
            'constructor-super': 'warn',
            'comma-dangle': 'off',
            eqeqeq: 'off',
            camelcase: 'off',
            curly: ['warn', 'all'],
            'no-case-declarations': 'warn',
            'no-class-assign': 'warn',
            'no-compare-neg-zero': 'warn',
            'no-cond-assign': 'warn',
            'no-console': 'warn',
            'no-const-assign': 'warn',
            'no-constant-condition': 'warn',
            'no-control-regex': 'warn',
            'no-debugger': 'warn',
            'no-delete-var': 'warn',
            'no-dupe-args': 'warn',
            'no-dupe-class-members': 'warn',
            'no-dupe-keys': 'warn',
            'no-duplicate-case': 'warn',
            'no-empty-character-class': 'warn',
            'no-empty-pattern': 'warn',
            'no-empty': 'warn',
            'no-ex-assign': 'warn',
            'no-extra-boolean-cast': 'warn',
            'no-extra-semi': 'warn',
            semi: [2, 'always'],
            'no-fallthrough': 'warn',
            'no-func-assign': 'warn',
            'no-global-assign': 'warn',
            'no-inner-declarations': 'warn',
            'no-invalid-regexp': 'warn',
            'no-irregular-whitespace': 'warn',
            'no-mixed-spaces-and-tabs': 'warn',
            'no-new-symbol': 'warn',
            'no-obj-calls': 'warn',
            'no-octal': 'warn',
            'no-redeclare': 'warn',
            'no-regex-spaces': 'warn',
            'no-prototype-builtins': 'off',
            'no-self-assign': 'warn',
            'no-sparse-arrays': 'warn',
            'no-this-before-super': 'warn',
            'no-undef': 'off',
            'no-unexpected-multiline': 'warn',
            'no-unreachable': 'warn',
            'no-unsafe-finally': 'warn',
            'no-unsafe-negation': 'warn',
            'no-unused-labels': 'warn',
            'no-unused-vars': 'off',
            'no-useless-escape': 'warn',
            'no-var': 'off',
            'require-yield': 'warn',
            'use-isnan': 'warn',
            'valid-typeof': 'warn',
            'jsdoc/check-alignment': 'warn',
            'jsdoc/check-examples': 'off',
            'jsdoc/check-indentation': 'warn',
            'jsdoc/check-param-names': 'warn',
            'jsdoc/check-syntax': 'warn',
            'jsdoc/check-tag-names': 'warn',
            'jsdoc/check-types': 'warn',
            'jsdoc/implements-on-classes': 'warn',
            'jsdoc/match-description': 'warn',
            'jsdoc/no-types': 'off',
            'jsdoc/no-undefined-types': 'off',
            'jsdoc/require-description-complete-sentence': 'warn',
            'jsdoc/require-example': 'off',
            'jsdoc/require-hyphen-before-param-description': 'warn',
            'jsdoc/require-jsdoc': 'off',
            'jsdoc/require-param': 'off',
            'jsdoc/require-param-description': 'off',
            'jsdoc/require-param-name': 'warn',
            'jsdoc/require-param-type': 'warn',
            'jsdoc/require-returns': 'off',
            'jsdoc/require-returns-check': 'off',
            'jsdoc/require-returns-description': 'off',
            'jsdoc/require-returns-type': 'warn',
            'jsdoc/valid-types': 'warn',
            'servicenow/no-hardcoded-sysids': 'warn',
            'servicenow/dont-use-gr-as-variablename': 'warn',
            'servicenow/no-private-class-methods': 'warn',
            'servicenow/no-packages-calls': 'warn',
            'servicenow/no-at-method': 'warn',
            'servicenow/no-promise': 'warn',
            'servicenow/no-regexp-lookbehind': 'warn',
            'servicenow/no-setprototypeof': 'warn',
            'servicenow/no-shared-memory-atomics': 'warn',
            'servicenow/no-async-await': 'warn',
            'servicenow/no-proxy-internal-calls': 'warn',
            'servicenow/no-typed-arrays': 'warn',
            'space-before-function-paren': 'off',
            'eol-last': 'off',
            'id-blacklist': ['error', 'err', 'e', 'cb', 'callback'],

            'prettier/prettier': [
                'error',
                {
                    singleQuote: true
                }
            ],

            'arrow-body-style': 'off',
            'prefer-arrow-callback': 'off',

            quotes: [
                'error',
                'single',
                {
                    avoidEscape: true
                }
            ],

            'object-shorthand': 'off'
        }
    }
];
