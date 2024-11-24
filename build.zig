const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const myzql = b.dependency("myzql", .{ .target = target, .optimize = optimize });
    const exe = b.addExecutable(.{
        .name = "damp",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("myzql", myzql.module("myzql"));
    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    const run_step = b.step("run", "Run the server");
    run_step.dependOn(&run_cmd.step);
}
