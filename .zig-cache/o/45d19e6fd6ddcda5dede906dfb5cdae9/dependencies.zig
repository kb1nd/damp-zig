pub const packages = struct {
    pub const @"1220276bfd080f184d931f7fbd63769151100abfaf047472cb9c09da5a03af3a2b21" = struct {
        pub const build_root = "C:\\Users\\micro\\AppData\\Local\\zig\\p\\1220276bfd080f184d931f7fbd63769151100abfaf047472cb9c09da5a03af3a2b21";
        pub const build_zig = @import("1220276bfd080f184d931f7fbd63769151100abfaf047472cb9c09da5a03af3a2b21");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"12207fd0dcec0e9b8f8798c0196aa55263cec4736b4cb70365ad4e9a81adac799d95" = struct {
        pub const build_root = "C:\\Users\\micro\\AppData\\Local\\zig\\p\\12207fd0dcec0e9b8f8798c0196aa55263cec4736b4cb70365ad4e9a81adac799d95";
        pub const build_zig = @import("12207fd0dcec0e9b8f8798c0196aa55263cec4736b4cb70365ad4e9a81adac799d95");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "122084a9d77d05c33b1a559882e34a018e2c8d4d1a017ccebe5a8c956c16d545fd0a" },
            .{ "websocket", "122081ec5cd2ea4c62816e3fb85df473b8ce77a48c8fbfc8e1bfc5fc405da9e2db54" },
        };
    };
    pub const @"122081ec5cd2ea4c62816e3fb85df473b8ce77a48c8fbfc8e1bfc5fc405da9e2db54" = struct {
        pub const build_root = "C:\\Users\\micro\\AppData\\Local\\zig\\p\\122081ec5cd2ea4c62816e3fb85df473b8ce77a48c8fbfc8e1bfc5fc405da9e2db54";
        pub const build_zig = @import("122081ec5cd2ea4c62816e3fb85df473b8ce77a48c8fbfc8e1bfc5fc405da9e2db54");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"122084a9d77d05c33b1a559882e34a018e2c8d4d1a017ccebe5a8c956c16d545fd0a" = struct {
        pub const build_root = "C:\\Users\\micro\\AppData\\Local\\zig\\p\\122084a9d77d05c33b1a559882e34a018e2c8d4d1a017ccebe5a8c956c16d545fd0a";
        pub const build_zig = @import("122084a9d77d05c33b1a559882e34a018e2c8d4d1a017ccebe5a8c956c16d545fd0a");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "ws", "1220276bfd080f184d931f7fbd63769151100abfaf047472cb9c09da5a03af3a2b21" },
    .{ "http", "12207fd0dcec0e9b8f8798c0196aa55263cec4736b4cb70365ad4e9a81adac799d95" },
};
