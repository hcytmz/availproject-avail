use da_runtime::GenesisConfig;

use crate::chain_spec::{
	chain_properties,
	locals::{dev_endowed_accounts, dev_sudo, make_genesis},
	tech_committee_from_authorities, AuthorityKeys, ChainSpec, ChainType, FORK_ID, PROTOCOL_ID,
};

pub fn chain_spec() -> ChainSpec {
	let empty_boot_nodes = vec![];
	ChainSpec::from_genesis(
		"Avail Local Tri",
		"Avail Local",
		ChainType::Local,
		config_genesis,
		empty_boot_nodes,
		None,
		PROTOCOL_ID,
		FORK_ID,
		chain_properties(),
		Default::default(),
	)
}

/// Local Tri Chain genesis configuration.
///
///
/// It defines:
/// - `Alice`, `Bob`, and `Charlie` as initial authorities.
/// - `Alice` as `sudo` account.
/// - All devs account are endowed.
///
fn config_genesis() -> GenesisConfig {
	let mut authorities = ["Alice", "Bob", "Charlie"]
		.into_iter()
		.map(AuthorityKeys::from_seed)
		.collect::<Vec<_>>();

	// Charlie uses same account for stash
	authorities
		.get_mut(2)
		.map(|auth| auth.stash = auth.controller.clone());

	let tc_members = tech_committee_from_authorities(&authorities);
	let endowed_accs = dev_endowed_accounts();
	let sudo = dev_sudo();

	make_genesis(sudo, authorities, tc_members, endowed_accs)
}
