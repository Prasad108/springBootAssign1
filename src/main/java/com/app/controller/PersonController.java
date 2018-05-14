package com.app.controller;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
   

import com.app.Service.PersonService;
import com.app.pojo.Person;

import com.google.gson.Gson;




@Controller
public class PersonController {
	

	@Autowired
	PersonService personService;
	
	Gson gson = new Gson();
	

	@RequestMapping("/index")
	public String welcome(Map<String, Object> model) {
		System.out.println("********************default Method for application**********");
		return "index";
	}
	
	@RequestMapping(value = "/showPerson", method = RequestMethod.GET)
	public String showPerson() {

		System.out.println("**********inside showPerson controller**********");

		return "showPerson";

	}
	
	@RequestMapping(value = "/addPerson", method = RequestMethod.GET)
	public String addPerson() {

		System.out.println("**********inside addPerson controller**********");

		return "addPerson";

	}
	
	
	
	 @RequestMapping(value = "/GetAllPersonList", method = RequestMethod.POST)
	 @ResponseBody
	    public String GetAllPersonList( ){
		 
			System.out.println("**********from GetAllPersonList controller**********");
			List<Person> personList=personService.getall();
			String JSON=gson.toJson(personList);
			return JSON;
	 }
	 
	
	 
	 @RequestMapping(value="/SavePerson", method = RequestMethod.POST)
		@ResponseBody
		public String SavePersonPOST(@RequestBody Person person)
		 {
			 System.out.println("**********inside SavePersonPOST controller**********");	
			
			
			 personService.create(person);
			 return gson.toJson(person);
			
		 }
	 
	 @RequestMapping(value="/DeletePerson/{id}", method = RequestMethod.POST)
		@ResponseBody
		public String DeletePersonPOST(@PathVariable("id") int id)
		 {
			 System.out.println("**********inside SavePersonPOST controller**********");	
			
			 String response="";
			try {
			 personService.delet(personService.find(id));
			  response="{\"message\":\"successfull\"}";
			}
			catch(Exception e)
			{
			 response="{\"message\":\"failed to delete persone\"}";
			}
			
			return response;
			
		 }
	 
	 @RequestMapping(value="/UpdatePerson", method = RequestMethod.POST)
		@ResponseBody
		public String UpdatePerson(@RequestBody Person person)
		 {
			 System.out.println("**********inside UpdatePerson controller**********");	
			
			
			 personService.update(person);
			 return gson.toJson(person);
			
		 }
	 
	@RequestMapping(value="/GetPerson/{id}", method = RequestMethod.POST)
	@ResponseBody
	public String GetPerson(@PathVariable("id") int id)
		 {
			 System.out.println("**********inside GetPerson controller**********");	
			
			
			 Person person=personService.find(id);
			 return gson.toJson(person);
			
		 }
	 
	 
	

}	
	

