/*
* generated by Xtext
*/
package com.xtext.rest.rdsl;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class RestDslStandaloneSetup extends RestDslStandaloneSetupGenerated{

	public static void doSetup() {
		new RestDslStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}
