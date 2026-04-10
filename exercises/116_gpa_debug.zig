//
// GeneralPurposeAllocator was renamed in Zig 0.16 to DebugAllocator.
// It is one of the most important tools for real system programming
// and deep memory management.
//
// Unlike page_allocator (which gives you raw OS pages directly), the
// DebugAllocator adds safety checks, leak detection, double-free
// protection, and even stack traces when something goes wrong.
//
// It is specifically designed for safety and development rather than
// pure performance. While it is slower than page_allocator or
// c_allocator, while you are developing it is your absolute best
// friend — it will literally scream at you if you forget to free memory!
//
// Let's create our first DebugAllocator and manage a small slice of memory.
//
// In newer versions of Zig, the default initialization pattern `.{}` for
// the DebugAllocator is deprecated. Instead, you should use `.init`.
//
const std = @import("std");

pub fn main() !void {
    // We instantiate a DebugAllocator. We can configure it by passing a
    // configuration struct. Here, we'll explicitly turn safety on.
    //
    // TODO: Create a DebugAllocator with safety checks turned on.
    // Replace `???` with `std.heap.DebugAllocator(.{ .safety = true }).init`.
    var gpa = ???;

    // When the program finishes (or if it returns early due to an error),
    // we want to make sure the allocator cleans up and checks for leaks.
    // `gpa.deinit()` returns an enum indicating whether any memory was leaked.
    // We can assign it to `_` to safely ignore the enum result in this simple
    // example, but the allocator will still print leaks to the standard error!
    //
    // TODO: Deinitialize the allocator at the end of the scope using `defer`.
    // Replace `???` with `_ = gpa.deinit()`.
    defer ???;

    // To actually allocate memory, we need to get the generic `std.mem.Allocator`
    // interface from our DebugAllocator. This is what we pass to functions.
    const allocator = gpa.allocator();

    // Now let's allocate 64 bytes of memory!
    const slice = try allocator.alloc(u8, 64);

    // We can write to our newly allocated memory.
    @memset(slice, 0xaa);

    // This matches the expected output from build.zig!
    std.debug.print("Allocated 64 bytes safely with GPA. First byte is 0x{x}\n", .{slice[0]});

    // We must remember to free the memory we allocated!
    // If you forget this, DebugAllocator will report a memory leak when
    // deinit() is called at the end of the program!
    //
    // TODO: Free the slice using `allocator.free()`.
    // Replace `???` with `allocator.free(slice)`.
    ???;
}