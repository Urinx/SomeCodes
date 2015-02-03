function supportsImports(){
	return 'import' in document.createElement('link');
}

function supportsTemplate() {
	return 'content' in document.createElement('template');
}

function supportsCustomElements() {
	return 'registerElement' in document;
}