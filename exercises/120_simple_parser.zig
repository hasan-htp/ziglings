//
// Now we turn our lexer idea into a tiny parser!
// A parser takes the tokens and actually computes something useful
// based on their structure and meaning.
//
// In this case we will parse the simple expression "42 + 1337"
// and actually calculate the mathematical result.
//
// This is how real system tools work:
// 1. Lexer breaks text into tokens
// 2. Parser understands the structure
// 3. Evaluator/Compiler performs the action
//
// Let's build a parser that finds the two numbers, converts them
// from strings into integers, and adds them together!
//
const std = @import("std");

pub fn main() !void {
    const input = "42 + 1337";

    // We'll store our parsed numbers here.
    // Optionals let us express "we haven't found this yet".
    var first_num: ?u32 = null;
    var second_num: ?u32 = null;

    var i: usize = 0;
    while (i < input.len) {
        const c = input[i];

        switch (c) {
            ' ', '\n', '\t', '\r', '+' => {
                // For this simple parser, we'll just skip whitespace and the '+' sign.
                // We assume the input is always correctly formatted as "NUM + NUM".
                i += 1;
            },

            '0'...'9' => {
                const start = i;

                // Advance to the end of the number just like in our lexer
                while (i < input.len and input[i] >= '0' and input[i] <= '9') {
                    i += 1;
                }

                const number_str = input[start..i];

                // TODO: Parse `number_str` into a u32 integer.
                // Hint: Use `try std.fmt.parseInt(u32, number_str, 10)`.
                // Replace `???` with the parsing function call.
                const parsed_val = ???;

                // Store the parsed value in the correct variable
                if (first_num == null) {
                    first_num = parsed_val;
                } else {
                    second_num = parsed_val;
                }
            },

            else => {
                i += 1;
            }
        }
    }

    // Now let's calculate the result!
    // Since we used optionals, we need to unwrap them with `.?`
    if (first_num != null and second_num != null) {
        // TODO: Add the two unwrapped numbers together.
        // Replace `???` with `first_num.? + second_num.?`.
        const result = ???;
        std.debug.print("Result: {}\n", .{result});
    } else {
        std.debug.print("Failed to parse both numbers!\n", .{});
    }
}