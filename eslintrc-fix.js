// Add this to your .eslintrc.js rules section:
module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  ignorePatterns: [
    "**/storybook-static/**/*",
    "**/playwright-report/**/*",
    "shop-middleware/**/*",
  ],
  plugins: ["vitest"],
  parser: "vue-eslint-parser",
  parserOptions: {
    parser: "@typescript-eslint/parser",
    ecmaVersion: "latest",
    sourceType: "module",
  },
  extends: ["@nuxt/eslint-config", "plugin:prettier/recommended", "prettier"],
  overrides: [
    // The storyblok Components can have single-word-names, others don't
    {
      files: "storyblok/**/*.vue",
      rules: {
        "vue/multi-word-component-names": ["off"],
      },
    },
  ],
  rules: {
    // ADD THIS LINE - catches undefined variables
    "no-undef": "error",
    
    "@typescript-eslint/no-explicit-any": 1,
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        vars: "all",
        varsIgnorePattern: "^_",
        args: "after-used",
        argsIgnorePattern: "^_",
        ignoreRestSiblings: false,
      },
    ],
    // no console logs
    "no-console": ["error", { allow: ["error", "warn", "info"] }],
  },
};
