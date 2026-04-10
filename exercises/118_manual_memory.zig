//
// Now we go really deep into the system.
//
// Sometimes you want to talk directly to the operating system
// and ask for raw memory pages (usually 4096 bytes at a time).
//
// This is exactly what std.heap.page_allocator does. It is very fast
// because it bypasses any user-space memory management and goes
// straight to the OS (via mmap on Linux/macOS or VirtualAlloc on Windows).
//
// However, there is a catch: you are 100% responsible for freeing
// the memory yourself. There is no safety net, no leak detection,
// and no hand-holding. This is real system programming territory.
//
// Often, page_allocator is used as the backing "child allocator" for
// other, more sophisticated allocators (like ArenaAllocator or DebugAllocator),
// but sometimes you just need raw pages for yourself.
//
// Let's allocate exactly one page of memory!
//
const std = @import("std");

pub fn main() !void {
    // The page_allocator is a global instance, so we don't need to initialize it.
    // It implements the standard `std.mem.Allocator` interface.
    const allocator = std.heap.page_allocator;

    // TODO: Ask the allocator for exactly 4096 bytes of memory (a standard page size).
    // This is done by allocating a slice of 4096 `u8` elements.
    // Replace `???` with `try allocator.alloc(u8, 4096)`.
    const page = ???;

    // As always, we must ensure we free what we allocate.
    // If you forget this here, the OS will reclaim it when the program exits,
    // but in a long-running program, this would be a catastrophic memory leak!
    //
    // TODO: Use `defer` to free the allocated page.
    // Replace `???` with `allocator.free(page)`.
    defer ???;

    // Write a pattern at the start of the page so we can see it worked.
    // We are just modifying the memory to prove we really own it.
    @memset(page[0..16], 0xbb);

    // Let's output a success message to prove we did it!
    // This is the output the test runner expects.
    std.debug.print("Successfully allocated and will free one full memory page.\n", .{});
    
    // While raw page allocation is powerful, remember that it's usually 
    // better to use an ArenaAllocator or DebugAllocator for general usage, 
    // as they provide better ergonomics and safety guarantees!
}