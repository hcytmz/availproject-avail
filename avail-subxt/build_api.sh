#!/bin/sh
../../subxt/target/debug/subxt codegen \
	--derive Clone \
	--derive PartialEq \
	--derive Eq \
	--derive_for_type da_primitives::header::extension::HeaderExtension=serde::Serialize \
	--derive_for_type da_primitives::header::extension::HeaderExtension=serde::Deserialize  \
	--derive_for_type da_primitives::header::extension::v1::HeaderExtension=serde::Serialize  \
	--derive_for_type da_primitives::header::extension::v1::HeaderExtension=serde::Deserialize  \
	--derive_for_type da_primitives::header::extension::v1::HeaderExtension=Default \
	--derive_for_type da_primitives::kate_commitment::KateCommitment=serde::Serialize \
	--derive_for_type da_primitives::kate_commitment::KateCommitment=serde::Deserialize \
	--derive_for_type da_primitives::kate_commitment::KateCommitment=Default \
	--derive_for_type da_primitives::asdr::data_lookup::DataLookup=serde::Serialize \
	--derive_for_type da_primitives::asdr::data_lookup::DataLookup=serde::Deserialize \
	--derive_for_type da_primitives::asdr::data_lookup::DataLookup=Default \
	--derive_for_type da_primitives::asdr::data_lookup::DataLookupIndexItem=serde::Serialize \
	--derive_for_type da_primitives::asdr::data_lookup::DataLookupIndexItem=serde::Deserialize \
	--derive_for_type da_primitives::asdr::AppId=serde::Serialize \
	--derive_for_type da_primitives::asdr::AppId=serde::Deserialize \
	--derive_for_type da_primitives::asdr::AppId=Default \
	--derive_for_type da_primitives::asdr::AppId=Copy \
	--derive_for_type da_primitives::asdr::AppId=derive_more::From \
	--url http://localhost:9933 \
	| sed -En "s/pub struct KateCommitment/#\[serde\(rename_all = \"camelCase\"\)\] \0/p" \
	| rustfmt --edition=2021 --emit=stdout > src/api_dev.rs
