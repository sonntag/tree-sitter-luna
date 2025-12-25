module.exports = grammar({
  name: 'luna',

  extras: $ => [
    /\s/,           // Whitespace
    $.comment       // Comments
  ],

  rules: {
    // Top-level source file
    source_file: $ => repeat($._form),

    // A form is any valid Luna expression
    _form: $ => choice(
      $.list,
      $.vector,
      $.map,
      $.number,
      $.string,
      $.keyword,
      $.symbol,
      $.quasiquote,
      $.unquote,
      $.unquote_splice,
      $.quote,
      $.comment
    ),

    // Comments
    comment: $ => token(seq(';', /.*/)),

    // Numbers (integers only for now, matching Luna's current implementation)
    number: $ => token(seq(optional('-'), /[0-9]+/)),

    // Strings with basic escape sequences and interpolation
    string: $ => seq(
      '"',
      repeat(choice(
        token.immediate(/[^"\\$]/),
        seq('\\', choice('"', '\\', 'n', 't', 'r', '$')),
        $.string_interpolation,
        $.string_expression,
        token.immediate('$')  // Bare $ that's not interpolation
      )),
      '"'
    ),

    // String interpolation ${var}
    string_interpolation: $ => seq(
      token.immediate('${'),
      $.symbol,
      '}'
    ),

    // String expression interpolation $(expr)
    string_expression: $ => seq(
      token.immediate('$('),
      $._form,
      ')'
    ),

    // Keywords (start with :)
    keyword: $ => token(seq(':', /[a-zA-Z_][a-zA-Z0-9_\-?!*]*/)),

    // Symbols (identifiers) - matching Luna's tokenizer
    // Can start with: a-z A-Z _ + - * / < > = ! ?
    // Can contain: above plus digits, dot (for qualified names), &, #
    // # suffix is used for gensyms in macros
    symbol: $ => token(/[a-zA-Z_+\-*/<>=!?][a-zA-Z0-9_+\-*/<>=!?.&#]*/),

    // Quote: 'expr
    quote: $ => seq("'", $._form),

    // Quasiquote: `expr
    quasiquote: $ => seq('`', $._form),

    // Unquote: ~expr
    unquote: $ => seq('~', $._form),

    // Unquote-splice: ~@expr
    unquote_splice: $ => seq('~@', $._form),

    // Lists (parentheses)
    list: $ => seq(
      '(',
      repeat($._form),
      ')'
    ),

    // Vectors (square brackets)
    vector: $ => seq(
      '[',
      repeat($._form),
      ']'
    ),

    // Maps (curly braces) - pairs of key-value
    map: $ => seq(
      '{',
      repeat(seq($._form, $._form)),
      '}'
    )
  }
});
