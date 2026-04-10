//
// Sometimes you need to allocate many small pieces of memory that
// all live for the exact same short period of time (for example,
// when parsing a file, handling a web request, or computing a temporary
// data structure).
//
// ArenaAllocator is absolutely perfect for this. You allocate as much as
// you want, as often as you want, and then you free everything at once
// with a single `deinit()` call.
//
// Under the hood, ArenaAllocator wraps another allocator (often the
// page_allocator). It requests large chunks of memory from the child
// allocator and hands out smaller pieces to you.
//
// No individual free() calls are needed! This pattern is extremely common
// and used everywhere in real system-level Zig code.
//
// Let's practice using the ArenaAllocator to manage multiple strings.
//
const std = @import("std");

pub fn main() !void {
    // First, we initialize an ArenaAllocator.
    // It requires a "child allocator" to request its large memory blocks from.
    // We will give it the operating system's raw page allocator.
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);

    // We want the arena to free all its memory when we are done.
    // By deferring the deinitialization, we ensure cleanup happens
    // regardless of how this function exits.
    //
    // TODO: Ensure the arena is deinitialized at the end of the scope.
    // Replace `???` with `arena.deinit()`.
    defer ???;

    // Just like with the DebugAllocator, we need to extract the generic
    // allocator interface to actually use it.
    //
    // TODO: Get the generic allocator interface from the arena.
    // Replace `???` with `arena.allocator()`.
    const allocator = ???;

    // Now we can allocate multiple pieces of memory.
    // The `dupe` function duplicates a slice, allocating exactly enough
    // memory to hold the copy. This requires an allocator.
    const name1 = try allocator.dupe(u8, "Zig");
    const name2 = try allocator.dupe(u8, "is");
    const name3 = try allocator.dupe(u8, "awesome for systems programming!");

    // We print out our assembled sentence.
    std.debug.print("{s} {s} {s}\n", .{ name1, name2, name3 });

    // Notice: we did NOT call free() on name1, name2, or name3.
    // We don't have to! The arena cleans everything up when it is deinited.
    //
    // In fact, calling free() on an ArenaAllocator does nothing unless
    // it happens to be the very last allocation made! It's super fast!
}