const std = @import("std");
const myzql = @import("myzql");
pub fn inSlice(comptime T: type, list: []const T, search: T) bool {
    for (list) |object| {
        switch (object) {
            search => return true,
        }
    }
    return false;
}
pub fn handleConnection(conn: std.net.StreamServer.Connection, gpa: std.heap.GeneralPurposeAllocator) !void {
    const structure = struct { id: u8, payload: u8, method: u8 };
    var buf: [300]u8 = undefined;
    const bytes = try conn.stream.read(&buf);
    const parsed = try std.json.parseFromSlice(
        structure,
        gpa,
        bytes,
        .{},
    );
    switch (inSlice(u8, dummy, parsed.value.id)) {
        true => std.debug.print("Wilmer gutten min klarte seg selv i dag", .{}),
    }
    conn.stream.close();
}
pub fn main() !void {
    var gpa_impl = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa_impl.deinit() == .leak) {
        std.log.warn("Memmory leak detected\n", .{});
    };
    const gpa = gpa_impl.allocator();
    var client = try myzql.conn.Conn.init(
        gpa,
        &.{
            .username = try std.os.getEnvVarOwned(gpa, "username"),
            .password = try std.os.getEnvVarOwned(gpa, "password"),
            .database = try std.os.getEnvVarOwned(gpa, "database"),
            .address = std.net.getAddressList(gpa, try std.os.getEnvVarOwned(gpa, "address"), try std.os.getEnvVarOwned(gpa, "port")),
        },
    );
    defer client.deinit();

    const server = std.net.StreamServer.init(.{
        .reuse_port = true,
        .reuse_address = true,
    });
    const address = try std.net.Address.resolveIp("0.0.0.0", try std.os.getEnvVarOwned(gpa, "port"));
    try server.listen(address);
    while (true) {
        const conn = try server.accept();
        try handleConnection(conn, gpa);
    }
}
