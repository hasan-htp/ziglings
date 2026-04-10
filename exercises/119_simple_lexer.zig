//
// A lexer (also called a tokenizer or scanner) is the first step in
// any parser, compiler, or interpreter.
//
// It takes raw text (a string of characters) and breaks it into small,
// meaningful pieces called "tokens". Instead of dealing with individual
// characters like '4', '2', ' ', '+', the rest of the program can deal
// with logical concepts like NUMBER, PLUS, STRING, etc.
//
// Many system tools (command line parsers, config readers, network
// protocol parsers, and even small languages) start with a lexer.
//
// Let's build a tiny lexer that can recognize numbers and the '+' sign,
// while skipping any whitespace.
//
const std = @import("std");

pub fn main() !void {
    const input = "42 + 1337";

    var i: usize = 0;

    // We will walk through the string character by character.
    while (i < input.len) {
        const c = input[i];

        switch (c) {
            // Skip whitespace characters
            ' ', '\n', '\t', '\r' => {
                i += 1;
            },

            // Recognize a plus token
            '+' => {
                std.debug.print("Token: plus\n", .{});
                i += 1;
            },

            // Recognize a number token
            '0'...'9' => {
                // We found the start of a number!
                // Now we need to keep reading characters as long as they are digits.
                const start = i;

                // TODO: Write a while loop that advances `i` as long as:
                // 1) `i < input.len`
                // 2) `input[i]` is between '0' and '9' (inclusive)
                // Hint: you can chain conditions with `and`.
                // Replace `???` with the correct condition.
                while (???) {
                    i += 1;
                }

                // Now that we have found the end of the number, we can slice it!
                const number_str = input[start..i];
                std.debug.print("Token: number {s}\n", .{number_str});
            },

            else => {
                std.debug.print("Unknown character: {c}\n", .{c});
                i += 1;
            }
        }
    }
}