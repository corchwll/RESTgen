package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.jersey.JAXBResolverContent
import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyBaseContextResolver
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator

class JerseyFramework implements IRESTFramework {
	
	val IFileSystemAccess fsa;
	val RESTConfiguration config
	
	new(IFileSystemAccess fsa, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	override generateResources(RESTResourceCollection resourceCol) {
		val IResourceGenerator generator = new JerseyResourceGenerator();
		
		for(r: resourceCol.getResources){
			fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/" + r.name + "Resource" + Constants.JAVA, generator.generate(r, config))
		}
	}
	
	override generateMisc(RESTResourceCollection resourceCol) {
		val IResolverContent jaxb = new JAXBResolverContent(fsa, resourceCol.getResources);
		val IResolverContent genson = new GensonResolverContent(fsa, resourceCol.getResources);
		
		val JerseyBaseContextResolver gensonResolver = new JerseyBaseContextResolver(fsa, genson);
		gensonResolver.generateResolver();  //Mapper to customize JSON or XML output
		val JerseyBaseContextResolver jaxbResolver = new JerseyBaseContextResolver(fsa, jaxb);
		//jaxbResolver.generateResolver();
		
		val CustomAnnotations annons = new CustomAnnotations(config, fsa, resourceCol.getUserResource);
		annons.generateAuth();
		annons.generatePATCH();
	
	}
	
}