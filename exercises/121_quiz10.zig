//
// Quiz Time: The Alien Cargo Parser!
//
// Congratulations on making it this far! You've successfully navigated
// through pointers, memory allocators, and even built a mini lexer and parser.
//
// Now it's time to put everything together. The friendly aliens from
// exercise 047 have returned, and this time they brought gifts! They
// sent us a cargo manifest, which is just a single string of numbers
// separated by spaces.
//
// Your task is to build a highly robust systems-level parser to read it.
//
// You will:
// 1. Safely manage memory using BOTH a DebugAllocator and an ArenaAllocator.
// 2. Lex the string to find the individual number slices.
// 3. Duplicate those strings into the Arena (just to show off!).
// 4. Parse the integers and sum them up.
//
// There are 6 missing pieces (marked with ???). Can you fill them in?
//
const std = @import("std");

pub fn main() !void {
    std.debug.print("--- Alien Cargo Manifest ---\n", .{});

    // ------------------------------------------------------------------------
    // MEMORY ALLOCATION SETUP
    // ------------------------------------------------------------------------

    // 1. The aliens demand maximum safety.
    // Create a DebugAllocator with safety turned on.
    // Hint: Don't forget the `.init` at the end!
    var gpa = ???;
    
    // 2. Always clean up your DebugAllocator!
    // Remember that deinit() returns a leak check result (an enum). We don't
    // need to store it, but we can't just ignore a return value in Zig.
    // Hint: Assign it to `_` inside your defer statement!
    defer ???;

    // Extract the generic allocator interface from our GPA.
    const base_allocator = gpa.allocator();

    // 3. We are going to allocate several temporary strings.
    // Instead of tracking and freeing them one by one, use an ArenaAllocator.
    // Pass it our safe `base_allocator` so it has somewhere to get raw memory.
    var arena = ???(base_allocator);

    // 4. Deinitialize the arena at the end of the scope.
    // This single line will free all the duplicated strings at once!
    defer ???;

    // Extract the generic allocator interface specifically for the Arena.
    const arena_allocator = arena.allocator();


    // ------------------------------------------------------------------------
    // THE LEXER AND PARSER
    // ------------------------------------------------------------------------

    // The alien manifest: 42 crates of plumbus, 1337 crates of fleeb,
    // and 10 crates of pure dark matter.
    const input = "42 1337 10";
    var total_cargo: u32 = 0;

    var i: usize = 0;
    
    // Lex the input string by walking through it character by character.
    while (i < input.len) {
        const c = input[i];

        switch (c) {
            // Skip over the spaces
            ' ' => {
                i += 1;
            },

            // When we find a digit, we extract the whole number token
            '0'...'9' => {
                const start = i;
                
                // 5. We must not read past the end of the input string!
                // Add the condition that keeps `i` within bounds.
                // Hint: Check if `i` is less than `input.len`.
                while (??? and input[i] >= '0' and input[i] <= '9') {
                    i += 1;
                }
                
                // We successfully sliced out the number string.
                const number_str = input[start..i];

                // 6. The aliens require us to duplicate the string into 
                // memory using our ArenaAllocator before parsing it.
                // This proves we know how to use the allocator!
                // Hint: Use the `dupe` function for `u8` slices.
                const str_copy = try ???;

                // Finally, parse our shiny copied string into a u32 integer
                // and add it to our total cargo count.
                const amount = try std.fmt.parseInt(u32, str_copy, 10);
                total_cargo += amount;
            },

            // We shouldn't encounter any other characters!
            else => {
                std.debug.print("Unknown alien symbol: {c}\n", .{c});
                i += 1;
            }
        }
    }

    // If you did everything correctly, this should print 1389!
    std.debug.print("Total alien cargo: {} items\n", .{total_cargo});
}