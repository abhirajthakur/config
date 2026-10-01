-- Rust. Install the toolchain with rustup first (rustup.rs): it provides cargo, rustfmt, clippy.
return {
	mason = { "rust-analyzer", "taplo" }, -- taplo = Cargo.toml / TOML language server + formatter
	treesitter = { "rust", "toml", "ron" },
	lsp_config = {
		rust_analyzer = {
			settings = {
				["rust-analyzer"] = {
					check = { command = "clippy" }, -- clippy lints as diagnostics
				},
			},
		},
	},
	formatters = {
		rust = { "rustfmt" },
		toml = { "taplo" },
	},
}
