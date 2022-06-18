return {
  black = {formatCommand = "black --fast -", formatStdin = true},
  eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintSource = "eslint"
  },
  flake8 = {
    lintCommand = "flake8 --max-line-length 110 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %t%n%n%n %m"},
    lintSource = "flake8"
  },
  goimports = {formatCommand = "goimports", formatStdin = true},
  html_prettier = {
    formatCommand = ([[
      prettier
      ${--tab-width:tabWidth}
      ${--single-quote:singleQuote}
      --parser html
    ]]):gsub("\n", "")
  },
  lua_format = {
    formatCommand = "lua-format -i --tab-width=2 --indent-width=2",
    formatStdin = true
  },
  mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
    lintFormats = {
      "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
    },
    lintSource = "mypy"
  },
  php_cs_fixer = {
    formatCommand = "php-cs-fixer --rules=@Symfony -n -q fix",
    formatStdin = true
  },
  prettier = {
    formatCommand = ([[
    prettier
    ${--config-precedence:configPrecedence}
    ${--tab-width:tabWidth}
    ${--single-quote:singleQuote}
    ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
  },
  revive = {
    lintCommand = "revive",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "revive"
  },
  shellfmt = {formatCommand = "shfmt ${-i:tabWidth}"}
}

