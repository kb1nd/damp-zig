const std = @import("std");
const myzql = @import("myzql");
const Table = union(enum) {
    table: std.ArrayListAligned,
    key: std.ArrayListAligned,
    id: std.ArrayListAligned,
};
const Row = struct {
    id: []const u8,
    key: []const u8,
};
const Protocol = struct {
    sec: []const u8,
    payload: []const u8,
    method: []const u8,
};
pub fn inSlice(comptime T: type, list: []const T, search: T) bool {
    for (list) |object| {
        switch (object) {
            search => return true,
        }
    }
    return false;
}
pub fn handleConnection(licenseTable: Table, conn: std.net.StreamServer.Connection, gpa: std.heap.GeneralPurposeAllocator) !void {
    const reqBuf = gpa.alloc(u8, undefined);
    const req = try std.http.Request.init(conn.reader());
    try req.parseHeaders(reqBuf);
    switch (std.mem.eql(u8, req.method, "POST")) {
        true => {
            const body = try std.json.parseFromSlice(
                Protocol,
                gpa,
                req.body,
                .{},
            );
            switch (std.mem.eql(u8, body.value.method, "payload")) {
                true => {
                    switch (inSlice(u8, licenseTable.id, body.value.sec)) {
                        true => std.debug.print("Wilmer gutten min klarte seg selv i dag", .{}),
                    }
                },
                else => {
                    switch (inSlice(u8, licenseTable.key, body.value.sec)) {
                        true => std.debug.print("Wilmer gutten min klarte seg selv i dag", .{}),
                    }
                },
            }
        },
        else => {},
    }
    conn.stream.close();
}
pub fn main() !void {
    var gpa_impl = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa_impl.deinit() == .leak) {
        std.log.warn("Memmory leak detected\n", .{});
    };
    const gpa = gpa_impl.allocator();
    const env_map = try gpa.create(std.process.EnvMap);
    env_map.* = try std.process.getEnvMap(gpa);
    defer env_map.deinit();
    var client = try myzql.conn.Conn.init(
        gpa,
        &.{
            .username = "dampupt", //env_map.get("username"),
            .password = "7733afcbe1e23f6a7c4046d9e0e06bf32e750e31", //env_map.get("password"),
            .database = "dampupt", //env_map.get("database"),
            .address = std.net.Address.initIp4(.{ 188, 245, 153, 167 }, 3307), //env_map.get("port")),
        },
    );
    defer client.deinit();
    const query = try client.queryRows("SELECT * FROM licenses");
    defer query.deinit();
    var licenses = Table{
        .table = std.ArrayList(Row).init(gpa),
        .key = std.ArrayList().init(gpa),
        .id = std.ArrayList().init(gpa),
    };
    while (try query.next()) {
        var row = query.getRow();
        try licenses.table.append(Row{
            .id = try row["id"].text(),
            .key = try row["key"].text(),
        });
        try licenses.id.append(try row["id"].text());
        try licenses.key.append(try row["key"].text());
    }
    const server = std.net.StreamServer.init(.{
        .reuse_port = true,
        .reuse_address = true,
    });
    const address = try std.net.Address.resolveIp("0.0.0.0", 10000); //env_map.get("port"));
    try server.listen(address);
    while (true) {
        const conn = try server.accept();
        try handleConnection(Table{ .table = licenses.table, .key = licenses.key, .id = licenses.id }, conn, gpa);
    }
}
