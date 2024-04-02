# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	ahash@0.8.11
	aho-corasick@1.1.3
	aligned@0.4.2
	anstream@0.6.13
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.6
	anyhow@1.0.81
	anymap2@0.13.0
	as-slice@0.2.1
	assert_cmd@2.0.14
	auth-git2@0.5.4
	autocfg@1.2.0
	bitflags@1.3.2
	bitflags@2.5.0
	block-buffer@0.10.4
	bstr@1.9.1
	cargo-husky@1.5.0
	cc@1.0.90
	cfg-if@1.0.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	colorchoice@1.0.0
	console@0.15.8
	const-random-macro@0.1.16
	const-random@0.1.18
	cpufeatures@0.2.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	crypto-common@0.1.6
	cvt@0.1.2
	deranged@0.3.11
	dialoguer@0.11.0
	difflib@0.4.0
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	doc-comment@0.3.3
	either@1.10.0
	encode_unicode@0.3.6
	env_filter@0.1.0
	env_logger@0.11.3
	equivalent@1.0.1
	errno@0.3.8
	faster-hex@0.9.0
	fastrand@2.0.2
	float-cmp@0.9.0
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs-err@2.11.0
	fs_at@0.1.10
	generic-array@0.14.7
	getrandom@0.2.12
	git2@0.18.3
	gix-actor@0.31.1
	gix-config-value@0.14.6
	gix-config@0.36.0
	gix-date@0.8.5
	gix-features@0.38.1
	gix-fs@0.10.1
	gix-glob@0.16.2
	gix-hash@0.14.2
	gix-lock@13.1.1
	gix-object@0.42.1
	gix-path@0.10.7
	gix-ref@0.43.0
	gix-sec@0.10.6
	gix-tempfile@13.1.1
	gix-trace@0.1.8
	gix-utils@0.1.11
	gix-validate@0.8.4
	globset@0.4.14
	hashbrown@0.14.3
	heck@0.5.0
	home@0.5.9
	humantime@2.1.0
	idna@0.5.0
	ignore@0.4.22
	indexmap@2.2.6
	indicatif@0.17.8
	indoc@2.0.5
	instant@0.1.12
	itertools@0.10.5
	itoa@1.0.11
	jobserver@0.1.28
	kstring@2.0.0
	lazy_static@1.4.0
	libc@0.2.153
	libgit2-sys@0.16.2+1.7.2
	libredox@0.0.1
	libssh2-sys@0.3.0
	libz-sys@1.1.16
	linux-raw-sys@0.4.13
	liquid-core@0.26.4
	liquid-derive@0.26.4
	liquid-lib@0.26.4
	liquid@0.26.4
	lock_api@0.4.11
	log@0.4.21
	memchr@2.7.1
	memmap2@0.9.4
	names@0.14.0
	nix@0.26.4
	normalize-line-endings@0.3.0
	normpath@1.2.0
	num-conv@0.1.0
	num-traits@0.2.18
	num_threads@0.1.7
	number_prefix@0.4.0
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.3+3.2.1
	openssl-sys@0.9.101
	openssl@0.10.64
	option-ext@0.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	path-absolutize@3.1.1
	path-dedot@3.1.1
	percent-encoding@2.3.1
	pest@2.7.8
	pest_derive@2.7.8
	pest_generator@2.7.8
	pest_meta@2.7.8
	pkg-config@0.3.30
	portable-atomic@1.6.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@3.1.0
	proc-macro2@1.0.79
	prodash@28.0.0
	quote@1.0.35
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.4.6
	regex-syntax@0.8.2
	regex@1.10.4
	remove_dir_all@0.8.2
	rhai@1.17.1
	rhai_codegen@2.0.0
	rustix@0.38.32
	same-file@1.0.6
	sanitize-filename@0.5.0
	scopeguard@1.2.0
	semver@1.0.22
	serde@1.0.197
	serde_derive@1.0.197
	serde_spanned@0.6.5
	sha1_smol@1.0.0
	sha2@0.10.8
	shell-words@1.1.0
	smallvec@1.13.2
	smartstring@1.0.1
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	syn@2.0.55
	tempfile@3.10.1
	terminal-prompt@0.2.3
	termtree@0.4.1
	thin-vec@0.2.13
	thiserror-impl@1.0.58
	thiserror@1.0.58
	time-core@0.1.2
	time-macros@0.2.17
	time@0.3.34
	tiny-keccak@2.0.2
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.22.9
	typenum@1.17.0
	ucd-trie@0.1.6
	unicode-bidi@0.3.15
	unicode-bom@2.0.3
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-width@0.1.11
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winnow@0.6.5
	zerocopy-derive@0.7.32
	zerocopy@0.7.32
	zeroize@1.7.0
"

inherit cargo

DESCRIPTION="cargo, make me a project"
HOMEPAGE="https://cargo-generate.github.io/cargo-generate"
SRC_URI="
	https://github.com/cargo-generate/cargo-generate/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CC0-1.0 MIT MPL-2.0 MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"
